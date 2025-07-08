module tb_binary_adder_tree;

  logic [15:0] A, B, C, D, E;
  logic [15:0] out;
  logic clk;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  always #5 clk = ~clk;

  property add_correctness;
    @(posedge clk)
      out == (A + B + C + D + E);
  endproperty

  assert property(add_correctness);

endmodule