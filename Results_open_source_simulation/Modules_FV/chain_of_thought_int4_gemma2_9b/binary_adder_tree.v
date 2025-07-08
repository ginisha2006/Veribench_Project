module tb_binary_adder_tree;

  reg [15:0] A, B, C, D, E;
  reg clk;
  wire [15:0] out;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  property p_add_correctness;
    @(posedge clk)
      out == A + B + C + D + E;
  endproperty

  property p_overflow;
    @(posedge clk)
      !| (out > 65535) | (out < 0);
  endproperty

  assert property (p_add_correctness);
  assert property (p_overflow);

  always #5 clk = ~clk;

endmodule