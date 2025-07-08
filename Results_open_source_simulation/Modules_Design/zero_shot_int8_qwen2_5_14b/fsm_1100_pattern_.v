module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

    typedef enum {S0,S1,S2,S3} state_t;
    state_t current_state,next_state;

    always @(posedge clk) begin
        if(rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case(current_state)
            S0: 
                if(bit_in == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            S1:
                if(bit_in == 1'b1)
                    next_state = S1;
                else
                    next_state = S2;
            S2:
                if(bit_in == 1'b0)
                    next_state = S3;
                else
                    next_state = S1;
            S3:
                if(bit_in == 1'b0)
                    next_state = S3;
                else
                    next_state = S1;
        default:
            next_state = S0;
        endcase
    end

    assign pattern_detected = (current_state == S3 && bit_in == 1'b0);

endmodule