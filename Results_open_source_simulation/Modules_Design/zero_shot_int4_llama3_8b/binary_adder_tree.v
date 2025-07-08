module binary_adder_tree;
input [15:0] A, B, C, D, E;
input clk;
output reg [15:0] out;

wire [15:0] sum1, sum2, sum3, sum4;
wire [15:0] carry1, carry2, carry3;

assign #1 sum1 = A + B;
assign #1 carry1 = (A[15] & B[15]) | (A[14] & B[14]);

assign #1 sum2 = sum1 + C;
assign #1 carry2 = (sum1[15] & C[15]) | (carry1 & C[14]);

assign #1 sum3 = sum2 + D;
assign #1 carry3 = (sum2[15] & D[15]) | (carry2 & D[14]);

assign #1 sum4 = sum3 + E;
assign #1 out = sum4;

always @(posedge clk)
begin
    if (~clk) begin
        out <= {out[14:0], 1'b0};
    end
    else begin
        out <= {out[14:0], 1'b0};
    end
end

endmodule