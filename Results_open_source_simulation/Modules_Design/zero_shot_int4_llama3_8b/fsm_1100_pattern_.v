module fsm_1100(
    input wire clk,
    input wire rst,
    input wire [2:0] bit_in,
    output reg pattern_detected
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk) begin
    if (rst) begin
        state <= 3'b0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        3'b000: next_state = (bit_in == 3'b110)? 3'b001 : 3'b000;
        3'b001: next_state = (bit_in[2] & ~bit_in[1])? 3'b010 : 3'b001;
        3'b010: next_state = (bit_in[0] & ~bit_in[1])? 3'b011 : 3'b010;
        3'b011: next_state = (bit_in[0] & ~bit_in[2])? 3'b100 : 3'b011;
        3'b100: next_state = (bit_in[2] & ~bit_in[0])? 3'b101 : 3'b100;
        3'b101: next_state = (bit_in[1] & ~bit_in[0])? 3'b110 : 3'b101;
        default: next_state = 3'b000;
    endcase
end

assign pattern_detected = (state == 3'b110);

endmodule