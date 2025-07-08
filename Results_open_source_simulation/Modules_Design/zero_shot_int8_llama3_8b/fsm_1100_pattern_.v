module fsm_1100(
    input wire clk,
    input wire rst,
    input wire [2:0] bit_in,
    output reg pattern_detected
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk)
begin
    if (rst) begin
        state <= 3'b000;
        pattern_detected <= 1'b0;
    end else begin
        state <= next_state;
    end
end

always @(state, bit_in)
begin
    case (state)
        3'b000:
            begin
                next_state = 3'b001;
                pattern_detected <= 1'b0;
            end
        3'b001:
            begin
                next_state = 3'b010;
                pattern_detected <= 1'b0;
            end
        3'b010:
            begin
                next_state = 3'b011;
                pattern_detected <= 1'b0;
            end
        3'b011:
            begin
                next_state = 3'b100;
                pattern_detected <= 1'b0;
            end
        3'b100:
            begin
                next_state = 3'b101;
                pattern_detected <= 1'b0;
            end
        3'b101:
            begin
                next_state = 3'b110;
                pattern_detected <= 1'b0;
            end
        3'b110:
            begin
                next_state = 3'b111;
                pattern_detected <= 1'b0;
            end
        3'b111:
            begin
                next_state = 3'b000;
                pattern_detected <= 1'b1;
            end
    endcase
end

endmodule