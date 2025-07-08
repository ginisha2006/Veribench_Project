module binary_adder_tree (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [15:0] C,
    input wire [15:0] D,
    input wire [15:0] E,
    input wire clk,
    output reg [15:0] out
);
    reg [15:0] stage1_1;
    reg [15:0] stage1_2;
    reg [15:0] stage2;

    always @(posedge clk) begin
        stage1_1 <= A + B;
        stage1_2 <= C + D;
    end

    always @(posedge clk) begin
        stage2 <= stage1_1 + E;
    end

    always @(posedge clk) begin
        out <= stage2 + stage1_2;
    end
endmodule