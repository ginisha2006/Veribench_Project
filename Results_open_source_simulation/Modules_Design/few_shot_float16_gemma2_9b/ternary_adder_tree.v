module ternary_adder_tree #(parameter WIDTH=16) (
    input [WIDTH-1:0] A, B, C, D, E,
    input CLK,
    output reg [WIDTH-1:0] OUT
);

  // Internal signals for pipeline stages
  reg [WIDTH-1:0] stage1, stage2, stage3;

  always @(posedge CLK) begin
    stage1 <= {D[WIDTH-1], A[WIDTH-2:0] + B[WIDTH-2:0]};
    stage2 <= {E[WIDTH-1], stage1[WIDTH-2:0] + C[WIDTH-2:0]};
    OUT <= stage2;
  end

endmodule