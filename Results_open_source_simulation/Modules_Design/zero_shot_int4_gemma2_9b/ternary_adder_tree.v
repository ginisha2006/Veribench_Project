module ternary_adder_tree (
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input [WIDTH-1:0] C,
  input [WIDTH-1:0] D,
  input [WIDTH-1:0] E,
  input CLK,
  output [WIDTH-1:0] OUT
);

  // Instantiate ternary adders recursively
  genvar i;
  generate
    for (i = WIDTH/2; i > 0; i = i/2) begin : loop
      TernaryAdderTree #(WIDTH/2) adder_tree_instance (
        .A(A[2*i-1:2*i-2]),
        .B(B[2*i-1:2*i-2]),
        .C(C[2*i-1:2*i-2]),
        .D(D[2*i-1:2*i-2]),
        .E(E[2*i-1:2*i-2]),
        .CLK(CLK),
        .OUT(A[2*i-1:2*i-2])
      );
    end
  endgenerate

  assign OUT = A;

endmodule