module tb_binary_adder_tree;

  logic [15:0] A, B, C, D, E;
  logic [15:0] out;
  logic clk;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  property p_add_correctness;
    @(posedge clk)
      out == A + B + C + D + E;
  endproperty

  property p_overflow;
    @(posedge clk)
      !((A + B + C + D + E) > 15'hFFFF);
  endproperty

  assert property (p_add_correctness);
  assert property (p_overflow);

  always #5 clk = ~clk;

endmodule