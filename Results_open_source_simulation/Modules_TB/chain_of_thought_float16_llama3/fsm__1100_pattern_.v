Here is the Verilog testbench module:

fsm_1100_tb;

parameter CLK_PERIOD = 10;

reg clk;

reg rst;

reg bit_in;

wire pattern_detected;

initial begin

#(CLK_PERIOD*5) rst = 1'b1;

#(CLK_PERIOD) rst = 1'b0;

repeat (100) begin

#(CLK_PERIOD/2) clk = ~clk;

bit_in = 1'b0;

#(CLK_PERIOD/2) clk = ~clk;

bit_in = 1'b1;

#(CLK_PERIOD*4) bit_in = 1'b0;

#(CLK_PERIOD*4) bit_in = 1'b1;

#(CLK_PERIOD*4) bit_in = 1'b0;

#(CLK_PERIOD*4) bit_in = 1'b1;

#(CLK_PERIOD*4) bit_in = 1'b0;

$monitor($time," clk=%b, rst=%b, bit_in=%b, pattern_detected=%b\n", clk, rst, bit_in, pattern_detected);

end

initial begin

$display("Running test...");

#(CLK_PERIOD*10)$finish;

end

endmodule