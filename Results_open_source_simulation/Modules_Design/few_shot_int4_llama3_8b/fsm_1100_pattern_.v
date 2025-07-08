module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output logic pattern_detected
);
    reg state = 0; // Initial state is 0
    always @(posedge clk) begin
        if (rst) state <= 0;
        else case (state)
            0: state <= (bit_in)? 1 : 2;
            1: state <= (bit_in)? 3 : 0;
            2: state <= (bit_in)? 4 : 0;
            3: state <= (bit_in)? 5 : 0;
            4: state <= (bit_in)? 6 : 0;
            5: state <= 0;
            6: state <= 7;
            7: pattern_detected <= 1; // Pattern detected!
            default: state <= 0;
        endcase
    end
    assign pattern_detected = (state == 7); // Output is high when state is 7
endmodule