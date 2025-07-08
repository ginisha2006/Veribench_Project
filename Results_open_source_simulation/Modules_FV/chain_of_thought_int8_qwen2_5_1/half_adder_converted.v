module tb_half_adder (
    input a,
    input b,
    output sum,
    output carry
);

wire clk;

half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

always begin
    #5 clk = ~clk;
end

always @(*) begin assert (@(posedge clk) a[*1] |-> !($overflow(a + b))); end

assert (@(posedge clk) (a && !b) |=> sum == 1'b1;
    @(posedge clk) (!a && b) |=> sum == 1'b1;
    @(posedge clk) (!a && !b) |=> sum == 1'b0;
    @(posedge clk) (a && b) |=> sum == 1'b0);

assert (@(posedge clk) (a && b) |=> carry == 1'b1;
    @(posedge clk) (!a || !b) |=> carry == 1'b0);

always @(*) begin assert (@(negedge clk) $rose(clk) |-> sum === 1'b0 && carry === 1'b0); end

endmodule