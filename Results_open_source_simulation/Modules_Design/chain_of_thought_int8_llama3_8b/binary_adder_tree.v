module binary_adder_tree(clk, A, B, C, D, E, out);
input [15:0] A, B, C, D, E;
output reg [15:0] out;

wire [15:0] sum1, sum2, sum3, sum4;

assign sum1 = A + B;
assign sum2 = sum1 + C;
assign sum3 = sum2 + D;
assign sum4 = sum3 + E;

always @ (posedge clk)
begin
    out <= sum4;
end

endmodule