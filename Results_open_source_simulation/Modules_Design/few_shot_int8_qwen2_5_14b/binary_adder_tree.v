module binary_adder_tree (
    input wire [15:0] A, B, C, D, E,
    input wire clk,
    output reg [15:0] out
);
    reg [15:0] stage1_1, stage1_2, stage1_3;
    reg [15:0] stage2_1;

    always @(posedge clk) begin
        stage1_1 <= A + B;
        stage1_2 <= C + D;
        stage1_3 <= E;

        stage2_1 <= stage1_1 + stage1_2;

        out <= stage2_1 + stage1_3;
    end
endmodule