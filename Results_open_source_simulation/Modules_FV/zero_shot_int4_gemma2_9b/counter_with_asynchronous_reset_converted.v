module tb_counter;

  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (clk, reset, result, ena);

  assert property (p_count_increment && p_reset_to_zero && p_no_overflow);

  always #5 clk = ~clk;

endmodule