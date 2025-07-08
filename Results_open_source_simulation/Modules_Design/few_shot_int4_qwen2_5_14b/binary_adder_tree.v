module binary_adder_tree (
    input wire clk,
    input wire [15:0] A, B, C, D, E,
    output reg [15:0] out
);

reg [15:0] stage1_sum1, stage1_sum2, stage1_sum3;
reg [15:0] stage2_sum1, stage2_sum2;
reg [15:0] final_sum;

always @(posedge clk) begin
    // Stage 1 - Add pairs of inputs
    stage1_sum1 <= A + B;
    stage1_sum2 <= C + D;
    stage1_sum3 <= E;

    // Stage 2 - Add results from stage 1
    stage2_sum1 <= stage1_sum1 + stage1_sum2;
    stage2_sum2 <= stage1_sum3;

    // Final stage - Sum up all intermediate sums
    final_sum <= stage2_sum1 + stage2_sum2;
    
    // Assign final result to output
    out <= final_sum;
end

endmodule