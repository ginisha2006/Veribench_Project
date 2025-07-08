module ternary_adder_tree #(parameter WIDTH=16) (
    input [WIDTH-1:0] A, B, C, D, E,
    input CLK,
    output reg [WIDTH-1:0] OUT
);

  // Internal signals for pipeline stages
  reg [WIDTH-1:0] stage1, stage2, stage3;

  always @(posedge CLK) begin
    stage1 <= {A[WIDTH-1], B[WIDTH-1], C[WIDTH-1]};
    stage2 <= {stage1[WIDTH-1], stage1[WIDTH-2:0] + stage2};
    stage3 <= {stage2[WIDTH-1], stage2[WIDTH-2:0] + stage3};
    OUT <= stage3;
  end

endmodule