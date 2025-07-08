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

assert (@(posedge clk) disable iff (!($isunknown(a)) && !($isunknown(b)))
   ($rose(a) || $rose(b)) |-> ##1 !$isunknown(sum) && !$isunknown(carry));

assert (@(posedge clk) disable iff (!($isunknown(a)) && !($isunknown(b)))
   (a == 0 && b == 0) |=> sum == 0;
   (a == 1 && b == 0) |=> sum == 1;
   (a == 0 && b == 1) |=> sum == 1;
   (a == 1 && b == 1) |=> sum == 0);

assert (@(posedge clk) disable iff (!($isunknown(a)) && !($isunknown(b)))
   (a == 0 && b == 0) |=> carry == 0;
   (a == 1 && b == 0) |=> carry == 0;
   (a == 0 && b == 1) |=> carry == 0;
   (a == 1 && b == 1) |=> carry == 1);

endmodule