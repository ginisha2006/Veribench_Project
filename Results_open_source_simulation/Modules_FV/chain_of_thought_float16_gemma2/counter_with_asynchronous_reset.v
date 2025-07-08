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

  property p_reset;
    @(posedge clk) reset == 1  => result == 0;
  endproperty

  property p_increment;
    @(posedge clk) ena && !reset  => result == result + 1;
  endproperty

  assert property (p_reset);
  assert property (p_increment);

endmodule