module binary_adder_tree (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [15:0] C,
    input wire [15:0] D,
    input wire [15:0] E,
    input wire clk,
    output reg [15:0] out
);

reg [15:0] stage1_sum1;
reg [15:0] stage1_sum2;
reg [15:0] stage2_sum;

always @(posedge clk) begin
    stage1_sum1 <= A + B;
    stage1_sum2 <= C + D;
end

always @(posedge clk) begin
    stage2_sum <= stage1_sum1 + E + stage1_sum2;
end

always @(posedge clk) begin
    out <= stage2_sum;
end

endmodule