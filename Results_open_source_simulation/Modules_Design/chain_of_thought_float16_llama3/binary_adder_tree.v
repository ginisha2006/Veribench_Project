module binary_adder_tree(clk, A, B, C, D, E, out);
input wire [15:0] A;
input wire [15:0] B;
input wire [15:0] C;
input wire [15:0] D;
input wire [15:0] E;
input wire clk;
output reg [15:0] out;

reg [15:0] temp1, temp2, temp3, temp4, temp5;

always @(posedge clk) begin
    temp1 = A + B;
    temp2 = temp1 + C;
    temp3 = temp2 + D;
    temp4 = temp3 + E;
    out = temp4;
end

endmodule