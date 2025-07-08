module gray_count(clk, enable, reset, gray_count);
input wire clk;
input wire enable;
input wire reset;
output reg [7:0] gray_count;

always @(posedge clk) begin
    if (reset)
        gray_count <= 8'b00000000;
    else if (enable)
        gray_count <= {gray_count[6:0], gray_count[7]^gray_count[6]};
end

endmodule