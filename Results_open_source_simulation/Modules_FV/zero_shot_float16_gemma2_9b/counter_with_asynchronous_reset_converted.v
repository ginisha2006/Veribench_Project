module tb_counter;

  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  assert property (p_increment && p_reset && p_overflow);

  always #5 clk = ~clk;

endmodule