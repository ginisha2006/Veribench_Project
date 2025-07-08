module bcd_to_gray #(
    parameter BCD_WIDTH = 4,
    parameter GRAY_WIDTH = 4
)(
    input [BCD_WIDTH-1:0] bcd,
    output reg [GRAY_WIDTH-1:0] gray
);
    always @(*) begin
        case(bcd)
            4'b0000: gray <= 4'b0000;
            4'b0001: gray <= 4'b0001;
            4'b0010: gray <= 4'b0011;
            4'b0011: gray <= 4'b0010;
            4'b0100: gray <= 4'b0110;
            4'b0101: gray <= 4'b0111;
            4'b0110: gray <= 4'b0101;
            4'b0111: gray <= 4'b0100;
            4'b1000: gray <= 4'b1100;
            4'b1001: gray <= 4'b1101;
            default: gray <= 4'bxxxx; // This line is just a placeholder as x should not be used in synthesis.
        endcase
    end
endmodule