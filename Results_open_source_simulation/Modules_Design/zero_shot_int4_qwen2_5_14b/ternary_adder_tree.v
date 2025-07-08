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
    reg [WIDTH-1:0] stage1;
    reg [WIDTH-1:0] stage2;

    always @(posedge clk) begin
        stage1 <= a + b + c;
        stage2 <= stage1 + d + e;
        out <= stage2;
    end
endmodule