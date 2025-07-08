module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        S0: 
            if(bit_in == 1)
                next_state = S1;
            else
                next_state = S0;
        S1: 
            if(bit_in == 1)
                next_state = S2;
            else
                next_state = S0;
        S2: 
            if(bit_in == 0)
                next_state = S3;
            else
                next_state = S1;
        S3: 
            if(bit_in == 0)
                next_state = S3;
            else
                next_state = S1;
        default: next_state = S0;
    endcase
end

assign pattern_detected = (state == S3 && bit_in == 0);

endmodule