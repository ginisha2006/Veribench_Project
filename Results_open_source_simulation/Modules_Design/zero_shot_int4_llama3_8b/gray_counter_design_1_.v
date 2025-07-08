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

always @(gray_count) begin
    assign gray_count = {gray_count[6], gray_count[5], gray_count[4], gray_count[3],
                       gray_count[2], gray_count[1], gray_count[0], ~gray_count[6]};
end

endmodule