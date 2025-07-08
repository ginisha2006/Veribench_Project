module seven_seg_display #(parameter DATA_WIDTH = 4) (
    input [DATA_WIDTH-1:0] data,
    output reg [6:0] seg
);

always @(*) begin
    case(data)
        3'b0000: seg = 7'b1110111; // 0
        3'b0001: seg = 7'b1000011; // 1
        3'b0010: seg = 7'b1011011; // 2
        3'b0100: seg = 7'b1001111; // 3
        3'b0101: seg = 7'b1011111; // 4
        3'b0110: seg = 7'b1110000; // 5
        3'b0111: seg = 7'b1111001; // 6
        3'b1000: seg = 7'b1100011; // 7
        3'b1001: seg = 7'b1110011; // 8
        3'b1010: seg = 7'b1110111; // 9
        3'b1011: seg = 7'b1001110; // A
        3'b1100: seg = 7'b1000111; // B
        3'b1101: seg = 7'b1011110; // C
        3'b1110: seg = 7'b1000110; // D
        default: seg = 7'bx;
    endcase
end

endmodule