module tb_binary_adder_tree;

  reg clk;
  reg [15:0] A, B, C, D, E;
  wire [15:0] out;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  assert (@(posedge clk)
      out == A + B + C + D + E);

  always #5 clk = ~clk;

endmodule