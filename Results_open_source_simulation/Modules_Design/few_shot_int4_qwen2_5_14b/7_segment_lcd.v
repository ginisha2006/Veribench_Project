module seven_seg_display #(
    parameter DATA_WIDTH = 4
)
(
    input [DATA_WIDTH-1:0] data,
    output reg [6:0] seg
);

always @(*) begin
    case(data)
        4'b0000: seg = 7'b1000000; // 0
        4'b0001: seg = 7'b1111001; // 1
        4'b0010: seg = 7'b0100100; // 2
        4'b0011: seg = 7'b0110000; // 3
        4'b0100: seg = 7'b0011001; // 4
        4'b0101: seg = 7'b0011011; // 5
        4'b0110: seg = 7'b0001111; // 6
        4'b0111: seg = 7'b1110000; // 7
        4'b1000: seg = 7'b0000000; // 8
        4'b1001: seg = 7'b0000100; // 9
        4'b1010: seg = 7'b0001000; // A
        4'b1011: seg = 7'b0000010; // B
        4'b1100: seg = 7'b1111000; // C
        4'b1101: seg = 7'b0100001; // D
        4'b1110: seg = 7'b0000010; // E
        default: seg = 7'b0000000; // F
    endcase
end

endmodule