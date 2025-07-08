module tb_half_adder;

logic a, b, sum, carry;
half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

assert (@(posedge clk) disable iff (!rst_n) ((a == 0 && b == 0) => sum == 0) |
                         ((a == 0 && b == 1) => sum == 1) |
                         ((a == 1 && b == 0) => sum == 1) |
                         ((a == 1 && b == 1) => sum == 0));
assert (@(posedge clk) disable iff (!rst_n) ((a == 0 && b == 0) => carry == 0) |
                         ((a == 0 && b == 1) => carry == 0) |
                         ((a == 1 && b == 0) => carry == 0) |
                         ((a == 1 && b == 1) => carry == 1));
always @(*) begin assert (@(posedge clk) disable iff (!rst_n)!((a | b) == 1'b1)); end
always @(*) begin assert (@(posedge clk) disable iff (!rst_n)!((~a & ~b) == 1'b0)); end
always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((a == 1'b0) | (b == 1'b0))); end

endmodule