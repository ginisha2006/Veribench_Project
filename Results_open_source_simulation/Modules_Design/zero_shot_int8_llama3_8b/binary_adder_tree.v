module binary_adder_tree(
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input clk,
    output [15:0] out
);

wire [31:0] temp;

assign #1 temp = {A, B};

always @(posedge clk)
begin
    wire [15:0] sum1;
    assign sum1 = A + B;
    wire [15:0] sum2;
    assign sum2 = sum1 + C;
    wire [15:0] sum3;
    assign sum3 = sum2 + D;
    wire [15:0] sum4;
    assign sum4 = sum3 + E;
    assign out = sum4;
end

endmodule