module ternary_adder_tree #(
    parameter WIDTH = 16
)(
    input clk,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [WIDTH-1:0] c,
    input [WIDTH-1:0] d,
    input [WIDTH-1:0] e,
    output reg [WIDTH-1:0] out
);

reg [WIDTH-1:0] stage1_sum1, stage1_sum2;
reg [WIDTH-1:0] stage2_sum;

always @(posedge clk) begin
    // First stage of addition
    stage1_sum1 <= a + b;
    stage1_sum2 <= c + d;
    
    // Second stage of addition
    stage2_sum <= stage1_sum1 + stage1_sum2;
    
    // Final addition including the fifth input
    out <= stage2_sum + e;
end

endmodule