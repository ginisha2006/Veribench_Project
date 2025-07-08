module gray_count (
  input clk,
  input enable,
  input reset,
  output reg [7:0] gray_count
);

always @(posedge clk) begin
  if (reset) begin
    gray_count <= 0;
  end else if (enable) begin
    gray_count <= gray_count + 1;
  end
end

endmodule