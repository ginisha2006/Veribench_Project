module tb_half_adder;

logic a, b, sum, carry;
logic clk;

half_adder dut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

assert (@(posedge clk) ((a == 0 && b == 0) | (a == 1 && b == 1)) => sum == 0;
    @(posedge clk) ((a == 0 && b == 1) | (a == 1 && b == 0)) => sum == 1;
    @(posedge clk) (a == 1 && b == 1) => sum == 1);
assert (@(posedge clk) (a && b) => carry == 1;
    @(posedge clk) (!a &&!b) => carry == 0;
    @(posedge clk) (a &&!b) => carry == 1;
    @(posedge clk) (!a && b) => carry == 1);
always @(*) begin assert (@(posedge clk) ($onehot(a) && $onehot(b)) disable iff (!clk)); end
always @(*) begin assert (@(posedge clk) (!$onehot(a) &&!$onehot(b)) disable iff (!clk)); end
always @(*) begin assert (@(posedge clk) (a == 0 && b == 0) => $rose(carry); end
    @(posedge clk) (a == 1 && b == 1) => $fell(carry));

always #10 clk = ~clk; // Clock generation

endmodule