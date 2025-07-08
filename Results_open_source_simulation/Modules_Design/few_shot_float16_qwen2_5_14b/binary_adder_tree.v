module binary_adder_tree (
    input [15:0] A, B, C, D, E,
    input clk,
    output reg [15:0] out
);

reg [15:0] stage1_sum1, stage1_sum2;
reg [16:0] stage2_sum1, stage2_sum2;
reg [16:0] final_sum;

always @(posedge clk) begin
    // Stage 1: Add pairs of 16-bit numbers
    stage1_sum1 <= A + B;
    stage1_sum2 <= C + D;

    // Stage 2: Add results from stage 1 and E
    stage2_sum1 <= stage1_sum1 + E;
    stage2_sum2 <= stage1_sum1 + stage1_sum2;

    // Final addition
    final_sum <= stage2_sum1 + stage2_sum2;

    // Assign output (discard carry)
    out <= final_sum[15:0];
end

endmodule