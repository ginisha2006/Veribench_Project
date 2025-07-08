module fsm_1100(
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

    parameter [1:0] S0 = 2'b00;
    parameter [1:0] S1 = 2'b01;
    parameter [1:0] S2 = 2'b10;
    parameter [1:0] S3 = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            S0:
                if(bit_in == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            S1:
                if(bit_in == 1'b1)
                    next_state = S2;
                else
                    next_state = S0;
            S2:
                if(bit_in == 1'b0)
                    next_state = S3;
                else
                    next_state = S0;
            S3:
                if(bit_in == 1'b0)
                    next_state = S0;
                else
                    next_state = S0;
        default:
            next_state = S0;
        endcase
    end

    assign pattern_detected = (state == S3);

endmodule