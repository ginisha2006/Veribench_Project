module gray_count(clk, enable, reset, gray_count);

parameter WIDTH = 8;

reg [WIDTH-1:0] gray_count_reg;
reg [WIDTH-1:0] gray_count_next;

always @(posedge clk)
if (reset) begin
    gray_count_reg <= 0;
end else if (enable) begin
    gray_count_reg <= gray_count_next;
end

assign gray_count = gray_count_reg;

always @(gray_count_reg)
begin
    case (gray_count_reg)
        0: gray_count_next = 1;
        1: gray_count_next = 3;
        2: gray_count_next = 2;
        3: gray_count_next = 0;
        default: gray_count_next = gray_count_reg ^ (gray_count_reg >> 1);
    endcase
end

endmodule