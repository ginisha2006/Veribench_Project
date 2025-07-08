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
always @(posedge clk) begin
    wire [15:0] sum1;
    assign sum1 = temp[31:16] + temp[15:0];
    temp = {sum1, 16'b0};
end

assign #1 temp = {C, D};
always @(posedge clk) begin
    wire [15:0] sum2;
    assign sum2 = temp[31:16] + temp[15:0];
    temp = {sum2, 16'b0};
end

assign #1 temp = {E, sum1};
always @(posedge clk) begin
    wire [15:0] sum3;
    assign sum3 = temp[31:16] + temp[15:0];
    temp = {sum3, 16'b0};
end

assign #1 out = temp[31:16];

endmodule