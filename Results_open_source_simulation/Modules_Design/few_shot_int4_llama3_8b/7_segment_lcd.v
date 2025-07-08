module seven_seg_display #(parameter DATA_WIDTH=4) (
    input [DATA_WIDTH-1:0] data,
    output reg [6:0] seg
);
    always @(*) begin
        case(data)
            3'b0000: seg = 7'b11101110; // 0
            3'b0001: seg = 7'b00110011; // 1
            3'b0010: seg = 7'b11001100; // 2
            3'b0100: seg = 7'b10110010; // 3
            3'b0101: seg = 7'b10011100; // 4
            3'b0110: seg = 7'b10000011; // 5
            3'b0111: seg = 7'b11100001; // 6
            3'b1000: seg = 7'b10011111; // 7
            3'b1001: seg = 7'b10000000; // 8
            3'b1010: seg = 7'b11111110; // 9
            3'b1011: seg = 7'b10000001; // A
            3'b1100: seg = 7'b11111111; // B
            3'b1101: seg = 7'b10001110; // C
            3'b1110: seg = 7'b10010011; // D
            3'b1111: seg = 7'b10011111; // E
            default: seg = 7'bx; // F
        endcase
    end
endmodule