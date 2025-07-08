module binary_adder_tree (
    input [15:0] A, B, C, D, E,
    input clk,
    output [15:0] out
);

  wire [15:0] stage1_sum, stage2_sum, stage3_sum;
  wire carry1, carry2, carry3;

  half_adder ha1_0 (A[0], B[0], stage1_sum[0], carry1);
  half_adder ha1_1 (A[1], B[1], stage1_sum[1], carry2);
  half_adder ha1_2 (A[2], B[2], stage1_sum[2], carry3);
  // ... Add remaining half adders for stage 1

  full_adder fa2_0 (stage1_sum[0], C[0], carry1, stage2_sum[0], carry1);
  full_adder fa2_1 (stage1_sum[1], C[1], carry2, stage2_sum[1], carry2);
  full_adder fa2_2 (stage1_sum[2], C[2], carry3, stage2_sum[2], carry3);
  // ... Add remaining full adders for stage 2

  full_adder fa3_0 (stage2_sum[0], D[0], carry1, stage3_sum[0], carry1);
  full_adder fa3_1 (stage2_sum[1], D[1], carry2, stage3_sum[1], carry2);
  full_adder fa3_2 (stage2_sum[2], D[2], carry3, stage3_sum[2], carry3);
  // ... Add remaining full adders for stage 3

  full_adder fa4_0 (stage3_sum[0], E[0], carry1, out[0], carry1);
  full_adder fa4_1 (stage3_sum[1], E[1], carry2, out[1], carry2);
  full_adder fa4_2 (stage3_sum[2], E[2], carry3, out[2], carry3);
  // ... Add remaining full adders for stage 4



endmodule