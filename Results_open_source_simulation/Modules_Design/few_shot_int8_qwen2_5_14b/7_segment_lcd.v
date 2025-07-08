module seven_seg_display #(
    parameter DATA_WIDTH = 4
)(
    input [DATA_WIDTH-1:0] data,
    output reg [6:0] seg
);

always @(*) begin
    case(data)
        4'b0: seg = 7'b1000000; // 0
        4'b1: seg = 7'b1111001; // 1
        4'b2: seg = 7'b0100100; // 2
        4'b3: seg = 7'b0110000; // 3
        4'b4: seg = 7'b0011001; // 4
        4'b5: seg = 7'b0010010; // 5
        4'b6: seg = 7'b0000010; // 6
        4'b7: seg = 7'b1111000; // 7
        4'b8: seg = 7'b0000000; // 8
        4'b9: seg = 7'b0011000; // 9
        4'b10: seg = 7'b0001000; // A
        4'b11: seg = 7'b0000011; // B
        4'b12: seg = 7'b1000110; // C
        4'b13: seg = 7'b0100001; // D
        4'b14: seg = 7'b0000110; // E
        default: seg = 7'b0001110; // F
    endcase
end

endmodule