module fsm_1100 (
    input clk, rst,
    input bit_in,
    output pattern_detected
);
    reg [2:0] state = 3'b000; // Initial state is reset
    always @(posedge clk)
        if (rst) state <= 3'b000;
        else case (state)
            3'b000: state <= (bit_in == 1'b1)? 3'b001 : 3'b000;
            3'b001: state <= (bit_in == 1'b1)? 3'b010 : 3'b001;
            3'b010: state <= (bit_in == 1'b1)? 3'b011 : 3'b100;
            3'b011: state <= (bit_in == 1'b0)? 3'b000 : 3'b111;
            3'b100: state <= 3'b100;
            3'b111: pattern_detected <= 1'b1;
        endcase
    assign pattern_detected = (state == 3'b111);
endmodule