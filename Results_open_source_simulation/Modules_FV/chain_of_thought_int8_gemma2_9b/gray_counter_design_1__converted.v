module tb_gray_count;

  logic clk;
  logic enable;
  logic reset;
  logic [7:0] gray_count;

  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) gray_count != gray_count); end
  always @(*) begin assert (@(posedge reset) gray_count == 8'b0); end
  always @(*) begin assert (@(posedge clk) disable iff (enable == 0) gray_count == gray_count); end


endmodule