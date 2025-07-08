module fsm_1100(
    input wire clk,
    input wire rst,
    input wire [2:0] bit_in,
    output reg pattern_detected
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk)
if (rst) begin
    state <= 3'b000;
    pattern_detected <= 0;
end else begin
    state <= next_state;
end

always @(state or bit_in)
case (state)
    3'b000: begin
        if (bit_in == 3'b110) next_state = 3'b001; else next_state = 3'b000;
    end
    3'b001: begin
        if (bit_in == 3'b100) next_state = 3'b010; else next_state = 3'b000;
    end
    3'b010: begin
        if (bit_in == 3'b00) next_state = 3'b011; else next_state = 3'b000;
    end
    3'b011: begin
        if (bit_in == 3'b0) next_state = 3'b100; else next_state = 3'b000;
    end
    default: next_state = 3'b000;
endcase

assign pattern_detected = (state == 3'b100);

endmodule