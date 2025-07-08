module ternary_adder_tree (
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input [WIDTH-1:0] C,
  input [WIDTH-1:0] D,
  input [WIDTH-1:0] E,
  input CLK,
  output reg [WIDTH-1:0] OUT
);

  // Instantiate ternary adders recursively
  genvar i;
  generate
    for (i = 0; i < WIDTH/2; i = i + 1) begin : adder_stage
      ternary_adder #(.WIDTH(WIDTH)) adder_inst (
        .A(A[2*i+1:2*i]),
        .B(B[2*i+1:2*i]),
        .C(C[2*i+1:2*i]),
        .D(D[2*i+1:2*i]),
        .E(E[2*i+1:2*i]),
        .CLK(CLK),
        .OUT(OUT[2*i+1:2*i])
      );
    end
  endgenerate

endmodule