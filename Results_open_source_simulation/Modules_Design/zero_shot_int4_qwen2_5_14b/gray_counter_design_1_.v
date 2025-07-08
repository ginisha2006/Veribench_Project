module gray_count(
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
reg [3:0] binary_count;
always @(posedge clk) begin
    if (reset)
        binary_count <= 4'b0;
    else if (enable)
        binary_count <= binary_count + 1;
end

always @(binary_count) begin
    case (binary_count)
        4'b0000 : gray_count = 8'b00000000;
        4'b0001 : gray_count = 8'b00000001;
        4'b0011 : gray_count = 8'b00000011;
        4'b0010 : gray_count = 8'b00000010;
        4'b0110 : gray_count = 8'b00000110;
        4'b0111 : gray_count = 8'b00000111;
        4'b0101 : gray_count = 8'b00000101;
        4'b0100 : gray_count = 8'b00000100;
        4'b1100 : gray_count = 8'b00001100;
        4'b1101 : gray_count = 8'b00001101;
        4'b1111 : gray_count = 8'b00001111;
        4'b1110 : gray_count = 8'b00001110;
        4'b1010 : gray_count = 8'b00001010;
        4'b1011 : gray_count = 8'b00001011;
        4'b1001 : gray_count = 8'b00001001;
        4'b1000 : gray_count = 8'b00001000;
    endcase
end
endmodule