module tb_counter;

import uvm_pkg::*;

reg clk;

reg reset;

reg ena;

logic [7:0] result_exp;

counter dut (.clk(clk),.reset(reset),.ena(ena),.result(result));

property p_reset_to_zero;

@(posedge clk) disable iff (!reset) result == 0;

assert property (p_reset_to_zero);

property p_enable_increments;

@(posedge clk) disable iff (reset |!ena) result == result_exp;

always @(posedge clk) begin

if (reset) result_exp <= 0;

else if (ena) result_exp <= result_exp + 1;

end

assert property (p_enable_increments);

property p_overflow;

@(posedge clk) disable iff (reset |!ena) ($signed(result) >= 8'h100) => $fatal("Counter Overflow");

assert property (p_overflow);

property p_underflow;

@(posedge clk) disable iff (reset |!ena) ($signed(result) < 8'h0) => $fatal("Counter Underflow");

assert property (p_underflow);

initial begin

#10 reset = 1;

#10 reset = 0;

#100 ena = 1;

#10000 $stop();

end

endmodule