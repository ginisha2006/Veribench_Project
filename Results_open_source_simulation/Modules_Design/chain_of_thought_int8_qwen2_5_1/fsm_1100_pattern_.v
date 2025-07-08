module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

reg [1:0] state;
localparam IDLE = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;

always @(posedge clk) begin
    if (rst)
        state <= IDLE;
    else case(state)
        IDLE:
            if (bit_in == 1'b1)
                state <= S1;
            else
                state <= IDLE;
        S1:
            if (bit_in == 1'b1)
                state <= S2;
            else
                state <= IDLE;
        S2:
            if (bit_in == 1'b0)
                state <= IDLE;
            else
                state <= S1;
        default:
            state <= IDLE;
    endcase
end

assign pattern_detected = (state == S2 && bit_in == 1'b0);

endmodule