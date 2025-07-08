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

assert (@(posedge clk) disable iff (!($isunknown({a,b})))
 ($rose(a) |-> !($past((a == 1'b1 && b == 1'b1), 1))) &&
 ($rose(b) |-> !($past((a == 1'b1 && b == 1'b1), 1))));

assert (@(posedge clk) disable iff (!($isunknown({a,b})))
 (sum === (a ^ b)));

assert (@(posedge clk) disable iff (!($isunknown({a,b})))
 (carry === (a & b)));

endmodule