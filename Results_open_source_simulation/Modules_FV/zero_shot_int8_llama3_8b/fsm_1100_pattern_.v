module tb_fsm_1100;

import uvm_pkg::*;

reg clk;

bit rst;

bit bit_in;

reg pattern_detected;

fsm_1100 dut (.clk(clk),.rst(rst),.bit_in(bit_in),.pattern_detected(pattern_detected));

property p_initial_state_is_S0;

@(posedge clk) disable iff (!rst);

!dut.state;

endproperty

property p_transition_rules;

@(posedge clk) disable iff (!rst);

((dut.state == S0 && dut.bit_in) => dut.next_state == S1) ||

(dut.state == S0 &&!dut.bit_in) => dut.next_state == S0 ||

(dut.state == S1 && dut.bit_in) => dut.next_state == S2 ||

(dut.state == S1 &&!dut.bit_in) => dut.next_state == S0 ||

(dut.state == S2 && dut.bit_in) => dut.next_state == S2 ||

(dut.state == S2 &&!dut.bit_in) => dut.next_state == S3 ||

(dut.state == S3 && dut.bit_in) => dut.next_state == S1 ||

(dut.state == S3 &&!dut.bit_in) => dut.next_state == S0;

endproperty

property p_pattern_detected;

@(posedge clk) disable iff (!rst);

dut.pattern_detected => (dut.state == S3 &&!dut.bit_in);

endproperty

property p_overflow_underflow;

@(posedge clk) disable iff (!rst);

!(dut.state == S0 | dut.state == S1 | dut.state == S2 | dut.state == S3);

endproperty

assert property (p_initial_state_is_S0);

assert property (p_transition_rules);

assert property (p_pattern_detected);

assert property (p_overflow_underflow);

#10000000 $stop; // Simulation duration

endmodule