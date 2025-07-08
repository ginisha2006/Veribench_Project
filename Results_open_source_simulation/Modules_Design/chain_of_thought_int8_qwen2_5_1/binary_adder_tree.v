module binary_adder_tree #(parameter STAGES=3) (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire [15:0] C,
    input wire [15:0] D,
    input wire [15:0] E,
    input wire clk,
    output reg [15:0] out
);
    
reg [15:0] stage1_out1, stage1_out2;
reg [15:0] stage2_out;

always @(posedge clk) begin
    // Stage 1
    stage1_out1 <= A + B;
    stage1_out2 <= C + D;
    
    // Stage 2
    stage2_out <= stage1_out1 + E + stage1_out2;
    
    // Final Output
    out <= stage2_out;
end

endmodule