module bcd_to_gray #(parameter BCD_WIDTH = 4, parameter GRAY_WIDTH = 4)
(
    input [BCD_WIDTH-1:0] bcd,
    output reg [GRAY_WIDTH-1:0] gray
);

always @* begin
    casez ({bcd[3:0]})
        4'b0000: gray <= 4'h0;
        4'b0001: gray <= 4'h1;
        4'b0010: gray <= 4'h2;
        4'b0100: gray <= 4'h3;
        4'b0110: gray <= 5'h12;
        4'b1000: gray <= 5'h13;
        4'b1001: gray <= 5'h11;
        4'b1010: gray <= 5'h10;
        4'b1100: gray <= 5'h9;
        4'b1101: gray <= 5'h8;
        4'b1110: gray <= 5'h7;
        4'b1111: gray <= 5'h6;
        default: gray <= 4'h0;
    endcase
end

endmodule