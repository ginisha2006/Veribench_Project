fsm_1100_tb; 

parameter PERIOD = 10; // clock period in ns

reg clk;

reg rst;

reg bit_in;

wire pattern_detected;

initial begin

#($psqrt(PERIOD)); // delay for setup

clk = 1'b0;

rst = 1'b1;

bit_in = 1'b0;

#(PERIOD); // wait for one clock cycle

rst = 1'b0;

#($psqrt(PERIOD)); // delay for setup

bit_in = 1'b0;

repeat (4) begin

#(PERIOD / 2); // toggle clock

clk = ~clk;

#(PERIOD / 2); // toggle clock again

end

#(PERIOD * 5); // wait for some time

bit_in = 1'b1;

#(PERIOD / 2); // toggle clock

clk = ~clk;

#(PERIOD / 2); // toggle clock again

#(PERIOD * 5); // wait for some time

bit_in = 1'b0;

#(PERIOD / 2); // toggle clock

clk = ~clk;

#(PERIOD / 2); // toggle clock again

#(PERIOD * 5); // wait for some time

bit_in = 1'b1;

#(PERIOD / 2); // toggle clock

clk = ~clk;

#(PERIOD / 2); // toggle clock again

#(PERIOD * 5); // wait for some time

bit_in = 1'b0;

#(PERIOD / 2); // toggle clock

clk = ~clk;

#(PERIOD / 2); // toggle clock again

$monitor ($time, "pattern_detected: %b", pattern_detected);

end

always @(posedge clk)

#($psqrt(PERIOD)); // delay for setup

$display ("");

endmodule