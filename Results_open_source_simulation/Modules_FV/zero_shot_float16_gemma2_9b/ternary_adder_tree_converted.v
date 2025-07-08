module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  reg CLK;
  wire [WIDTH-1:0] OUT;

  ternary_adder_tree dut (
    .A(A), .B(B), .C(C), .D(D), .E(E), .CLK(CLK), .OUT(OUT)
  );

  always #5 CLK = ~CLK;

  always @(*) begin assert (@(posedge CLK) OUT == A + B + C + D + E); end

endmodule