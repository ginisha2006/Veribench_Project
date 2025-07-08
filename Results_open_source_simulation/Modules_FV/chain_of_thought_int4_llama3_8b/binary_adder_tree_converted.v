module tb_binary_adder_tree;

parameter PERIOD = 10;

input [15:0] A, B, C, D, E;
input clk;
output [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) => $equal(sum1, A + B)))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(C) && $onehot(D) => $equal(sum2, C + D)))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(sumreg1) && $onehot(sumreg2) => $equal(sum3, sumreg1 + sumreg2)))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(sumreg3) && $onehot(E) => $equal(sum4, sumreg3 + E)))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(sumreg4) => $equal(out, sumreg4)))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) && $onehot(C) && $onehot(D) && $onehot(E) => $distinct(out, {A, B, C, D, E})))); end
always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ($onehot(A) && $onehot(B) && $onehot(C) && $onehot(D) && $onehot(E) => $distinct(out, {A + B, C + D, sumreg1 + sumreg2, sumreg3 + E})))); end

endmodule