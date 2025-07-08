module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  always #5 clk = ~clk;

  assert property (p_count_increment || p_count_decrement || p_count_load || p_count_clear);
  assert property (p_overflow || p_underflow);

endmodule