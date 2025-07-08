module tb_gray_count;

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (clk, enable, reset, gray_count);

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) gray_count != gray_count); end
  always @(*) begin assert (@(posedge clk) gray_count == 8'hFF); end
  always @(*) begin assert (@(posedge clk) gray_count == 8'h00); end

endmodule