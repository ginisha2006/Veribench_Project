module bcd_to_gray #(parameter BCD_WIDTH = 4, parameter GRAY_WIDTH = 4)
    input [BCD_WIDTH-1:0] bcd,
    output reg [GRAY_WIDTH-1:0] gray;

always @(*)
begin
    casez ({bcd[3:0]})
        2'b0000: gray <= 2'b00;
        2'b0001: gray <= 2'b01;
        2'b0010: gray <= 2'b11;
        2'b0011: gray <= 2'b10;
        2'b0100: gray <= 2'b11;
        2'b0101: gray <= 2'b10;
        2'b0110: gray <= 2'b01;
        2'b0111: gray <= 2'b00;
        2'b1000: gray <= 2'b00;
        2'b1001: gray <= 2'b01;
        2'b1010: gray <= 2'b11;
        2'b1011: gray <= 2'b10;
        2'b1100: gray <= 2'b11;
        2'b1101: gray <= 2'b10;
        2'b1110: gray <= 2'b01;
        2'b1111: gray <= 2'b00;
        default: gray <= 2'bxx;
    endcase
end

endmodule