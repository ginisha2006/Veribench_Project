module tb_counter;

parameter CLOCK_PERIOD = 10; // adjust this value according to your requirements

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

property p_reset_value;
@(posedge clk) disable iff (!reset);
result == 0;
endproperty

property p_ena_increments;
@(posedge clk) disable iff (!ena &&!reset);
result == result_exp;
result_exp <= result + 1;
endproperty

property p_overflow;
@(posedge clk) disable iff (!ena &&!reset);
result >= 8'd128; // adjust this value according to your requirements
endproperty

property p_underflow;
@(posedge clk) disable iff (!ena &&!reset);
result < 8'd0; // adjust this value according to your requirements
endproperty

assert property (p_reset_value);
assert property (p_ena_increments);
assert property (p_overflow);
assert property (p_underflow);

initial begin
    #CLOCK_PERIOD * 5; // wait for some cycles before asserting reset
    reset = 1;
    #CLOCK_PERIOD * 2; // wait for some cycles after reset
    reset = 0;
    #CLOCK_PERIOD * 5; // wait for some cycles before enabling enable
    ena = 1;
    #CLOCK_PERIOD * 100; // wait for some cycles while enable is asserted
    ena = 0;
    #CLOCK_PERIOD * 5; // wait for some cycles after disabling enable
end

endmodule