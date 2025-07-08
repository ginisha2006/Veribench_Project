module tb_binary_adder_tree;

  reg [15:0] A, B, C, D, E;
  reg clk;
  wire [15:0] out;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  assert (@(posedge clk)
      out == A + B + C + D + E);
  assert (@(posedge clk)
      !| (out > 65535) | (out < 0));

  always #5 clk = ~clk;

endmodule