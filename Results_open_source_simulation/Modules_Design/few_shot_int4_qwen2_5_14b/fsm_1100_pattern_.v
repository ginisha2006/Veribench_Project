module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

enum {S0,S1,S2,S3} state,next_state;

always @(posedge clk)
begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*)
begin
    case(state)
        S0: begin
            if(bit_in == 1'b1)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if(bit_in == 1'b1)
                next_state = S2;
            else
                next_state = S0;
        end
        S2: begin
            if(bit_in == 1'b0)
                next_state = S3;
            else
                next_state = S1;
        end
        S3: begin
            if(bit_in == 1'b0)
                next_state = S3;
            else
                next_state = S1;
        end
    endcase
end

assign pattern_detected = (state == S3 && bit_in == 1'b0);

endmodule