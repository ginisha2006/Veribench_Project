module tb_counter;

  logic clk;
  logic reset;
  logic ena;
  logic [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .result(result),
    .ena(ena)
  );

  always @(*) begin assert (@(posedge clk) result == result + 1); end
  always @(*) begin assert (@(posedge reset) result == 0); end
  always @(*) begin assert (result >= 0 && result <= 255); end

endmodule