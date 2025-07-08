module tb_binary_adder_tree;

  logic [15:0] A, B, C, D, E;
  logic [15:0] out;
  logic clk;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  assert (@(posedge clk)
      out == A + B + C + D + E);
  assert (@(posedge clk)
      !((A + B + C + D + E) > 15'hFFFF));

  always #5 clk = ~clk;

endmodule