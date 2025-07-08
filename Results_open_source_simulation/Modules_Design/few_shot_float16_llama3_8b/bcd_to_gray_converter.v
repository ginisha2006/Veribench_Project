module bcd_to_gray #(parameter BCD_WIDTH=4, parameter GRAY_WIDTH=4) (
    input [BCD_WIDTH-1:0] bcd,
    output [GRAY_WIDTH-1:0] gray
);
    assign gray = {bcd[3]^bcd[2],bcd[2]^bcd[1],bcd[1]^bcd[0],bcd[0]};
endmodule