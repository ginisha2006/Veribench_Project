module ternary_adder_tree #(
    parameter WIDTH = 16
)(
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    input wire [WIDTH-1:0] C,
    input wire [WIDTH-1:0] D,
    input wire [WIDTH-1:0] E,
    input wire CLK,
    output reg [WIDTH-1:0] OUT
);
    reg [WIDTH-1:0] stage1_out;
    reg [WIDTH-1:0] stage2_out;

    always @(posedge CLK) begin
        stage1_out <= A + B + C;
    end

    always @(posedge CLK) begin
        stage2_out <= stage1_out + D + E;
    end

    always @(posedge CLK) begin
        OUT <= stage2_out;
    end
endmodule