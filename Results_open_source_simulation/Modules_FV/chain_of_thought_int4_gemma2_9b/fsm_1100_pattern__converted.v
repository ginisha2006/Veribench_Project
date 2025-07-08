module tb_fsm_1100;
  reg clk;
  reg rst;
  reg bit_in;
  wire pattern_detected;
  fsm_1100 dut (clk, rst, bit_in, pattern_detected);
  always #5 clk = ~clk;
  assert (@(posedge clk)
      $past(bit_in) == 1 && $past($past(bit_in)) == 1 && $past($past($past(bit_in))) == 0 && bit_in == 0);
endmodule