module seven_seg_display #(parameter DATA_WIDTH = 4)
    (input [DATA_WIDTH-1:0] data,
     output reg [6:0] seg);

always @(*) begin
    case(data)
        8'h0 : seg <= 7'b11000000;
        8'h1 : seg <= 7'b11110010;
        8'h2 : seg <= 7'b10100100;
        8'h3 : seg <= 7'b10101110;
        8'h4 : seg <= 7'b10011000;
        8'h5 : seg <= 7'b10011100;
        8'h6 : seg <= 7'b10011110;
        8'h7 : seg <= 7'b10000010;
        8'h8 : seg <= 7'b10000000;
        8'h9 : seg <= 7'b10001000;
        8'ha : seg <= 7'b10010000;
        8'hb : seg <= 7'b10011000;
        8'hc : seg <= 7'b10011010;
        8'hd : seg <= 7'b10011110;
        8'he : seg <= 7'b10001110;
        8'hf : seg <= 7'b10001111;
        default : seg <= 7'bxxxxxxx0; // default value
    endcase
end

endmodule