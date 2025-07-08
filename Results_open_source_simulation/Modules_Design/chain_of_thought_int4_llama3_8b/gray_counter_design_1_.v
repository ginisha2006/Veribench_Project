module gray_count(clk, enable, reset, gray_count);

input clk;

input enable;

input reset;

output reg [7:0] gray_count;

always @(posedge clk) begin

if (reset) begin

gray_count <= 0;

end else if (enable) begin

gray_count <= gray_count + 1'b1;

gray_count = gray_count ^ gray_count; // Gray code generation

end

end

endmodule