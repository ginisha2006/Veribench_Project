module seven_seg_display #(parameter DATA_WIDTH = 4);
input [DATA_WIDTH-1:0] data;
output [6:0] seg;

always @(posedge clock)
begin
case(data[3])
    8'h0: seg = 7'b11101110; // 0
    8'h1: seg = 7'b00110011; // 1
    8'h2: seg = 7'b10100010; // 2
    8'h3: seg = 7'b10011000; // 3
    8'h4: seg = 7'b01001110; // 4
    8'h5: seg = 7'b10111000; // 5
    8'h6: seg = 7'b10000010; // 6
    8'h7: seg = 7'b11111000; // 7
    8'h8: seg = 7'b10000000; // 8
    8'h9: seg = 7'b10011000; // 9
    8'ha: seg = 7'b01000000; // a
    8'hb: seg = 7'b10100000; // b
    8'hc: seg = 7'b10010000; // c
    8'hd: seg = 7'b10011000; // d
    8'he: seg = 7'b10100000; // e
    8'hf: seg = 7'b10000000; // f
    default: seg = 7'bx; // unknown
endcase
end

endmodule