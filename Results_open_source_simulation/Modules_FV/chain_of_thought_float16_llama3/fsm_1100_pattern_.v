module tb_fsm_1100;

input wire clk;

input wire rst;

input wire bit_in;

output reg pattern_detected;

reg [1:0] state, next_state;

typedef enum reg [1:0] {S0, S1, S2, S3} state_t;

property p_initial_state;

p_initial_state =!rst |=> ($rose(rst) |=> state == S0);

property p_next_state;

p_next_state = ((state == S0) |-> (next_state == (bit_in? S1 : S0)) |

(state == S1) |-> (next_state == (bit_in? S2 : S0)) |

(state == S2) |-> (next_state == (bit_in? S2 : S3)) |

(state == S3) |-> (next_state == (bit_in? S1 : S0));

property p_pattern_detected;

p_pattern_detected = (state == S3) && (!bit_in) |=> pattern_detected;

property p_edge_cases;

p_edge_cases =!(rst |=> (state!= S0));

property p_overflow_underflow;

p_overflow_underflow =!($fell(clk) |=> (state!= state));

property p_illegal_transitions;

p_illegal_transitions = (!(state == S0) |-> (next_state!= S0) |

!(state == S1) |-> (next_state!= S1) |

!(state == S2) |-> (next_state!= S2) |

!(state == S3) |-> (next_state!= S3));

fsm_1100 uut (.clk(clk),.rst(rst),.bit_in(bit_in),.pattern_detected(pattern_detected));

always #10 clk = ~clk;

assert property (p_initial_state);

assert property (p_next_state);

assert property (p_pattern_detected);

assert property (p_edge_cases);

assert property (p_overflow_underflow);

assert property (p_illegal_transitions);

endmodule