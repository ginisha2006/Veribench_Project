module tb_binary_adder_tree();

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;
logic clk;
logic [WIDTH-1:0] out;

binary_adder_tree dut (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .clk(clk),
   .out(out)
);

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((A == 0) | (B == 0)) => ($onehot(A + B))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((C == 0) | (D == 0)) => ($onehot(C + D))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((sum1 == 0) | (sum2 == 0)) => ($onehot(sum1 + sum2))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((sum3 == 0) | (E == 0)) => ($onehot(sum3 + E))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($onehot(out))); end
assert property (~p_overflow);
assert property (~p_underflow);

always #10 clk = ~clk; // Clock generation

initial begin
    clk = 0;
    repeat (100) @(posedge clk); // Run for 100 cycles
end

endmodule