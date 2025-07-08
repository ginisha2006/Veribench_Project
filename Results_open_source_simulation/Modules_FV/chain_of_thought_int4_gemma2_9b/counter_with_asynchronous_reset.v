module tb_counter;

  input clk;
  input reset;
  input ena;
  output [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  property p_count_up;
    @(posedge clk) result == result + 1;
  endproperty

  property p_reset_to_zero;
    @(posedge reset) result == 0;
  endproperty

  property p_no_increment_when_disabled;
    @(posedge clk) !ena && result == result;
  endproperty

  assert property (p_count_up);
  assert property (p_reset_to_zero);
  assert property (p_no_increment_when_disabled);

endmodule