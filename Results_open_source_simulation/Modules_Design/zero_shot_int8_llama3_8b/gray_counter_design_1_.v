module gray_count(
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);

always @(posedge clk) begin
    if (reset)
        gray_count <= 8'b00000000;
    else if (enable)
        gray_count <= gray_count + 1;
end

assign gray_count = gray_count ^ (gray_count >> 1);

endmodule