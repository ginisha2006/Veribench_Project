module tb_fsm_1100;

input wire clk;

input wire rst;

input wire bit_in;

output reg pattern_detected;

typedef enum reg [1:0] {S0, S1, S2, S3} state_t;

state_t state, next_state;

property p_initial_state;

assert property (@(posedge clk) state == S0);

property p_pattern_detected;

assert property (@(posedge clk) ($rose(rst) |->!pattern_detected);

property p_bit_in_transition;

assert property (@(posedge clk) ((state == S0 && bit_in) |-> next_state == S1) |

(state == S1 && bit_in) |-> next_state == S2) |

(state == S2 && bit_in) |-> next_state == S2) |

(state == S2 &&!bit_in) |-> next_state == S3) |

(state == S3 && bit_in) |-> next_state == S1) |

(state == S3 &&!bit_in) |-> next_state == S0);

property p_pattern_not_detected;

assert property (@(posedge clk) (!$rose(rst) && state!= S0) |->!pattern_detected);

fsm_1100 uut (.clk(clk),.rst(rst),.bit_in(bit_in),.pattern_detected(pattern_detected));

initial

#10 clk = 1;

#10 clk = 0;

#20 rst = 1;

#10 rst = 0;

#10000 $finish;

endmodule