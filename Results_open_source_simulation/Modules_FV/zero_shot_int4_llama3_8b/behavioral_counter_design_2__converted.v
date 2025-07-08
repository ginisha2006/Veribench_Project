module tb_behav_counter;

parameter CLOCK_PERIOD = 10; // adjust this value as per your requirement

logic clk;
logic reset_n;
logic load;
logic up_down;
logic [7:0] data_in;
logic [7:0] expected_output;
logic [7:0] actual_output;

behav_counter dut (
   .d(data_in),
   .clk(clk),
   .clear(~reset_n),
   .load(load),
   .up_down(up_down),
   .qd(actual_output)
);

always @(*) begin assert (@(posedge clk) disable iff (~reset_n); end
actual_output == 8'h00);
always @(*) begin assert (@(posedge clk) disable iff (~reset_n && load); end
actual_output == data_in);
always @(*) begin assert (@(posedge clk) disable iff (~reset_n &&!load && up_down); end
actual_output == actual_output + 1);
always @(*) begin assert (@(posedge clk) disable iff (~reset_n &&!load && ~up_down); end
actual_output == actual_output - 1);
always @(*) begin assert (@(posedegn clk) disable iff (~reset_n &&!load && (actual_output == 8'hFF || actual_output == 8'h00)); end
!(actual_output == 8'hFF) |!(actual_output == 8'h00));
always @(*) begin assert (@(posedge clk) disable iff (~reset_n &&!load && (actual_output == 8'hFF && up_down) || (actual_output == 8'h00 && ~up_down)); end
!(actual_output == 8'hFF) |!(actual_output == 8'h00));

initial begin
    #CLOCK_PERIOD * 5; // wait for some time before asserting reset
    reset_n = 1'b0;
    repeat (10) @(posedge clk); // wait for some time after reset
    reset_n = 1'b1;
    
    // Test load operation
    data_in = 8'h12;
    load = 1'b1;
    repeat (10) @(posedge clk);
    always @(*) begin assert (actual_output == 8'h12); end
    
    // Test increment operation
    load = 1'b0;
    up_down = 1'b1;
    repeat (10) @(posedge clk);
    always @(*) begin assert (actual_output == 8'h22); end
    
    // Test decrement operation
    up_down = 1'b0;
    repeat (10) @(posedge clk);
    always @(*) begin assert (actual_output == 8'h11); end
    
    // Test wraparound
    up_down = 1'b1;
    repeat (20) @(posedge clk);
    always @(*) begin assert (actual_output == 8'hFF); end
    
    // Test underflow
    up_down = 1'b0;
    repeat (20) @(posedge clk);
    always @(*) begin assert (actual_output == 8'h00); end
    
    $finish;
end

always #CLOCK_PERIOD clk = ~clk;

endmodule