module tb_counter;

logic clk;
logic reset;
logic ena;
logic [7:0] result_exp;
logic [7:0] result;

counter dut (
   .clk(clk),
   .reset(reset),
   .ena(ena),
   .result(result)
);

always @(*) begin assert (@(posedge clk) disable iff (!reset) result == 0); end
always @(*) begin assert (@(posedge clk) disable iff (!ena) result == $past(result)); end
always @(*) begin assert (@(posedge clk) disable iff (ena && result == 8'hff) result == 0); end
always @(*) begin assert (@(posedge clk) disable iff (ena && result == 8'h00) result == 8'hff); end

initial begin
    #10; // wait for some time before asserting
    reset = 1;
    #10;
    reset = 0;
    #100; // wait for some time before enabling enable
    ena = 1;
    #100000; // run for some time
    ena = 0;
    #100; // wait for some time before disabling enable
    ena = 0;
    #100000; // run for some time
    $finish;
end

endmodule