module fsm_1100 (clk, rst, bit_in, pattern_detected);

parameter STATE_IDLE = 3'b000, STATE_PATTERN_DETECTED = 3'b001, STATE_RESET = 3'b010;

reg [2:0] state, next_state;

always @(posedge clk) begin

if (rst) state <= STATE_RESET;

else state <= next_state;

end

always @(state, bit_in) begin

case (state)

STATE_IDLE: begin

next_state = (bit_in == 1'b1)? STATE_IDLE : ((bit_in == 1'b1 && bit_in[1] == 1'b1)? STATE_PATTERN_DETECTED : STATE_IDLE);

end

STATE_PATTERN_DETECTED: begin

next_state = (bit_in == 1'b0)? STATE_IDLE : STATE_PATTERN_DETECTED;

end

STATE_RESET: begin

next_state = STATE_IDLE;

end

default: next_state = STATE_IDLE;

endcase

assign pattern_detected = (state == STATE_PATTERN_DETECTED);

endmodule