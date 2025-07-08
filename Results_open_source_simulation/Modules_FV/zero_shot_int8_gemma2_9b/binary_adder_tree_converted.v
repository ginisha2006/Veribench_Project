module tb_binary_adder_tree;

  logic [15:0] A, B, C, D, E;
  logic [15:0] out;
  logic clk;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  always #5 clk = ~clk;

  assert (@(posedge clk)
      out == (A + B + C + D + E));

endmodule