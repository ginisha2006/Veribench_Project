module ternary_adder_tree #(
    parameter WIDTH = 16
)(
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    input wire [WIDTH-1:0] C,
    input wire [WIDTH-1:0] D,
    input wire [WIDTH-1:0] E,
    input wire             CLK,
    output reg  [WIDTH-1:0] OUT
);

reg [WIDTH-1:0] stage1;
reg [WIDTH-1:0] stage2;

always @(posedge CLK) begin
    stage1 <= A + B + C;
end

always @(posedge CLK) begin
    stage2 <= stage1 + D + E;
end

always @(posedge CLK) begin
    OUT <= stage2;
end

endmodule