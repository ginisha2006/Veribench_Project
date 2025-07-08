module tb_binary_adder_tree;

  reg [15:0] A, B, C, D, E;
  wire [15:0] out;
  
  binary_adder_tree dut (A, B, C, D, E, clk, out);

  always #5 clk = ~clk;
  reg clk;
  initial begin
    clk = 0;
  end

  property p_add_correctness;
    @(posedge clk)
      out == A + B + C + D + E;
  endproperty

  assert property (p_add_correctness);

endmodule