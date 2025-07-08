module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

reg [2:0] state, next_state;

parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          SD = 3'b100; // Detect state

always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*)
begin
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
                next_state = SD;
            else
                next_state = S1;
        SD: 
            if(bit_in == 0)
                next_state = SD;
            else
                next_state = S1;
        default: next_state = S0;
    endcase
end

assign pattern_detected = (state == SD);

endmodule