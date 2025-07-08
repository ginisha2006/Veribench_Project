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

  always @(*) begin assert (@(posedge clk) reset == 1  => result == 0); end
  always @(*) begin assert (@(posedge clk) ena && !reset  => result == result + 1); end

endmodule