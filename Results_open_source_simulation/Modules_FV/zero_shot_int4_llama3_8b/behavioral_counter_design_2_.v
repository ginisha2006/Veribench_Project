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

property p_reset_default_value;
@(posedge clk) disable iff (~reset_n);
actual_output == 8'h00;
endproperty

property p_load_correct;
@(posedge clk) disable iff (~reset_n && load);
actual_output == data_in;
endproperty

property p_up_count;
@(posedge clk) disable iff (~reset_n &&!load && up_down);
actual_output == actual_output + 1;
endproperty

property p_down_count;
@(posedge clk) disable iff (~reset_n &&!load && ~up_down);
actual_output == actual_output - 1;
endproperty

property p_wraparound;
@(posedegn clk) disable iff (~reset_n &&!load && (actual_output == 8'hFF || actual_output == 8'h00));
!(actual_output == 8'hFF) |!(actual_output == 8'h00);
endproperty

property p_overflow_underflow;
@(posedge clk) disable iff (~reset_n &&!load && (actual_output == 8'hFF && up_down) || (actual_output == 8'h00 && ~up_down));
!(actual_output == 8'hFF) |!(actual_output == 8'h00);
endproperty

assert property (p_reset_default_value);
assert property (p_load_correct);
assert property (p_up_count);
assert property (p_down_count);
assert property (p_wraparound);
assert property (p_overflow_underflow);

initial begin
    #CLOCK_PERIOD * 5; // wait for some time before asserting reset
    reset_n = 1'b0;
    repeat (10) @(posedge clk); // wait for some time after reset
    reset_n = 1'b1;
    
    // Test load operation
    data_in = 8'h12;
    load = 1'b1;
    repeat (10) @(posedge clk);
    assert (actual_output == 8'h12);
    
    // Test increment operation
    load = 1'b0;
    up_down = 1'b1;
    repeat (10) @(posedge clk);
    assert (actual_output == 8'h22);
    
    // Test decrement operation
    up_down = 1'b0;
    repeat (10) @(posedge clk);
    assert (actual_output == 8'h11);
    
    // Test wraparound
    up_down = 1'b1;
    repeat (20) @(posedge clk);
    assert (actual_output == 8'hFF);
    
    // Test underflow
    up_down = 1'b0;
    repeat (20) @(posedge clk);
    assert (actual_output == 8'h00);
    
    $finish;
end

always #CLOCK_PERIOD clk = ~clk;

endmodule