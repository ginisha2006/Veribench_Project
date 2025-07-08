module tb_counter;

  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (clk, reset, result, ena);

  property p_count_increment;
    @(posedge clk) result == result + 1;
  endproperty

  property p_reset_to_zero;
    @(posedge reset) result == 0;
  endproperty

  property p_no_overflow;
    result != 8'hFF;
  endproperty

  assert property (p_count_increment && p_reset_to_zero && p_no_overflow);

  always #5 clk = ~clk;

endmodule