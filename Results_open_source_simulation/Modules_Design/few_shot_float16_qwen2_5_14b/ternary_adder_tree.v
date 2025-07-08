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

reg [WIDTH-1:0] stage1_out1, stage1_out2;
reg [WIDTH-1:0] stage2_out;

always @(posedge clk) begin
    // First stage of addition
    stage1_out1 <= a + b;
    stage1_out2 <= c + d;
    
    // Second stage of addition
    stage2_out <= stage1_out1 + stage1_out2;
    
    // Final addition including 'e'
    out <= stage2_out + e;
end

endmodule