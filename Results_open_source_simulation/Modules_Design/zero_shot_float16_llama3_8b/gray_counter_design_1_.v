module gray_count(clk, enable, reset, gray_count);
parameter WIDTH = 8;
reg [WIDTH-1:0] gray_count_reg;
always @(posedge clk) begin
    if (reset) gray_count_reg <= 0;
    else if (enable) gray_count_reg <= gray_count_reg + 1'b1;
end
assign gray_count = gray_count_reg ^ (gray_count_reg >> 1);
endmodule