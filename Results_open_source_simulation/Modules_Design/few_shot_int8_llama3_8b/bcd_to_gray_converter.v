module bcd_to_gray #(parameter BCD_WIDTH=4, parameter GRAY_WIDTH=4) (
    input [BCD_WIDTH-1:0] bcd,
    output [GRAY_WIDTH-1:0] gray
);
    wire [BCD_WIDTH-1:0] temp;
    assign temp = {bcd[3],bcd[2]&~bcd[3],bcd[1]&~bcd[2],bcd[0]&~bcd[1]};
    assign gray = {temp[3]^temp[2],temp[2]^temp[1],temp[1]^temp[0],temp[0]};
endmodule