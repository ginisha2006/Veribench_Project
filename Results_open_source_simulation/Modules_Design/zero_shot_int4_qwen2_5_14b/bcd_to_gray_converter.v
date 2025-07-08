module bcd_to_gray #(
    parameter integer BCD_WIDTH = 4,
    parameter integer GRAY_WIDTH = 4
)(
    input [BCD_WIDTH-1:0] bcd,
    output reg [GRAY_WIDTH-1:0] gray
);
always @(*) begin
    gray[0] = bcd[0];
    for(integer i=1; i<GRAY_WIDTH; i=i+1)
        gray[i] = bcd[i]^bcd[i-1];
end
endmodule