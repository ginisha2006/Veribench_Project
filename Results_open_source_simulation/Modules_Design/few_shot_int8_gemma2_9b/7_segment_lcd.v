module seven_seg_display #(parameter DATA_WIDTH=4) (
    input [DATA_WIDTH-1:0] data,
    output [6:0] seg
);
    wire [6:0] digit_codes [0:3];
    
    assign digit_codes[0] = 7'b0011111;
    assign digit_codes[1] = 7'b0000110;
    assign digit_codes[2] = 7'b0101101;
    assign digit_codes[3] = 7'b0110011;
    assign digit_codes[4] = 7'b0111001;
    assign digit_codes[5] = 7'b0010011;
    assign digit_codes[6] = 7'b0111110;
    assign digit_codes[7] = 7'b0000000;
    
    assign seg = digit_codes[data[3:0]];
endmodule