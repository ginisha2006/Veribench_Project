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

  property always_incrementing;
    @(posedge clk) result == result + 1;
  endproperty

  property reset_to_zero;
    @(posedge reset) result == 0;
  endproperty

  property result_range;
    result >= 0 && result <= 255;
  endproperty

  assert property(always_incrementing);
  assert property(reset_to_zero);
  assert property(result_range);

endmodule