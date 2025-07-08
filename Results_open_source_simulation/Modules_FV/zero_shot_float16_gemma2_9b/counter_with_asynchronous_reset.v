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

  property p_increment;
    @(posedge clk) result == result + 1;
  endproperty

  property p_reset;
    @(posedge reset) result == 0;
  endproperty

  property p_overflow;
    @(posedge clk) result != {8{1'b1}};
  endproperty

  assert property (p_increment && p_reset && p_overflow);

  always #5 clk = ~clk;

endmodule