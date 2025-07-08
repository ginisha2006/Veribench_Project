module fsm_1100 (
    input clk, rst,
    input bit_in,
    output pattern_detected
);
    reg [2:0] state = 3'b000; // Initial state is reset
    always @(posedge clk)
        if (rst) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: state <= (bit_in)? 3'b001 : 3'b000;
                3'b001: state <= (bit_in)? 3'b010 : 3'b001;
                3'b010: state <= (bit_in)? 3'b011 : 3'b010;
                3'b011: state <= (bit_in)? 3'b100 : 3'b000;
                default: state <= 3'b000;
            endcase
        end
    assign pattern_detected = (state == 3'b100);
endmodule