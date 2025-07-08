module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

reg [1:0] state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(posedge clk) begin
    if (rst)
        state <= S0;
    else case(state)
        S0: if (bit_in == 1'b1) state <= S1; 
            else                state <= S0;
        S1: if (bit_in == 1'b1) state <= S2; 
            else                state <= S0;
        S2: if (bit_in == 1'b0) state <= S0; 
            else                state <= S1;
    endcase
end

assign pattern_detected = (state == S2 & bit_in == 1'b0);

endmodule