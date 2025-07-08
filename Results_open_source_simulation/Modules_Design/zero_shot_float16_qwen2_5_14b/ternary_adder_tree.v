module ternary_adder_tree #(
    parameter WIDTH = 16
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] C,
    input [WIDTH-1:0] D,
    input [WIDTH-1:0] E,
    input             CLK,
    output reg [WIDTH-1:0] OUT
);
    reg [WIDTH-1:0] stage1;
    reg [WIDTH-1:0] stage2;

    always @(posedge CLK) begin
        stage1 <= A + B + C;
        stage2 <= stage1 + D + E;
        OUT    <= stage2;
    end
endmodule