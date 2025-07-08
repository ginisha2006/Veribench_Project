module seven_seg_display #(parameter DATA_WIDTH = 4)(input [DATA_WIDTH-1:0] data, output reg [6:0] seg);

always @(posedge clock)
begin
    case(data[3:0])
        0 : seg <= 6'b1110110; // 0
        1 : seg <= 6'b0110011; // 1
        2 : seg <= 6'b1101101; // 2
        3 : seg <= 6'b0110111; // 3
        4 : seg <= 6'b1011011; // 4
        5 : seg <= 6'b1011110; // 5
        6 : seg <= 6'b1111001; // 6
        7 : seg <= 6'b0111101; // 7
        8 : seg <= 6'b1111111; // 8
        9 : seg <= 6'b1111011; // 9
        10 : seg <= 6'b1110111; // A
        11 : seg <= 6'b1011111; // B
        12 : seg <= 6'b1111101; // C
        13 : seg <= 6'b1111011; // D
        14 : seg <= 6'b1111110; // E
        15 : seg <= 6'b1111001; // F
        default : seg <= 6'b0000000;
    endcase
end

endmodule