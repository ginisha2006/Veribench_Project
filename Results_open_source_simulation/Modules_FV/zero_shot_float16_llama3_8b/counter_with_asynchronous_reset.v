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

property p_reset_to_zero;
    @(posedge clk) disable iff (!reset) result == 0;
endproperty

property p_enable_increments;
    @(posedge clk) disable iff (!ena) result == $past(result);
endproperty

property p_overflow;
    @(posedge clk) disable iff (ena && result == 8'hff) result == 0;
endproperty

property p_underflow;
    @(posedge clk) disable iff (ena && result == 8'h00) result == 8'hff;
endproperty

assert property (p_reset_to_zero);
assert property (p_enable_increments);
assert property (p_overflow);
assert property (p_underflow);

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