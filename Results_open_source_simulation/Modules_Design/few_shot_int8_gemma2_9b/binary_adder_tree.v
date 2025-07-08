module binary_adder_tree (
    input [15:0] A, B, C, D, E,
    input clk,
    output reg [15:0] out
);

  reg [15:0] stage1_sum;
  reg [15:0] stage2_sum;
  reg [15:0] stage3_sum;

  always @(posedge clk) begin
    stage1_sum <= A + B;
    stage2_sum <= stage1_sum + C;
    stage3_sum <= stage2_sum + D;
    out <= stage3_sum + E;
  end

endmodule