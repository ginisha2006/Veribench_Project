module tb_gray_count;

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (clk, enable, reset, gray_count);

  always @(*) begin assert (@(posedge reset) gray_count == 8'b00000000); end
  always @(*) begin assert (@(posedge clk) disable iff (enable == 0)); end
  always @(*) begin assert ($sformatf("Gray sequence check failed"); end
    @(posedge clk) gray_count != gray_count[7:1]);


endmodule