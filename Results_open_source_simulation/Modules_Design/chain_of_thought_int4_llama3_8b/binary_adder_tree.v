module binary_adder_tree(clk, A, B, C, D, E, out);

input [15:0] A, B, C, D, E;

input clk;

output [15:0] out;

wire [15:0] t1, t2, t3, t4, t5;

assign t1 = A + B;

always @(posedge clk) begin

   assign t2 = t1 + C;

end

always @(posedge clk) begin

   assign t3 = t2 + D;

end

always @(posedge clk) begin

   assign t4 = t3 + E;

end

always @(posedge clk) begin

   assign out = t4;

end

endmodule