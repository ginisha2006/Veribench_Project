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
    !((result == 8'hFF) && (ena)) || ((result == 8'h00) && (ena));
  endproperty

  assert property (p_increment);
  assert property (p_reset);
  assert property (p_overflow);

  always #5 clk = ~clk;

endmodule