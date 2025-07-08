module ternary_adder_tree (
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input [WIDTH-1:0] C,
  input [WIDTH-1:0] D,
  input [WIDTH-1:0] E,
  input CLK,
  output [WIDTH-1:0] OUT
);

  // Instantiate ternary adders
  genvar i;
  generate
    for (i = 0; i < WIDTH/3; i = i + 1) begin : adder_loop
      ternary_adder #(.WIDTH(3)) adder_inst (
        .A(A[i*3+2:i*3]),
        .B(B[i*3+2:i*3]),
        .C(C[i*3+2:i*3]),
        .D(D[i*3+2:i*3]),
        .E(E[i*3+2:i*3]),
        .CLK(CLK),
        .OUT(OUT[i*3+2:i*3])
      );
    end
  endgenerate

endmodule