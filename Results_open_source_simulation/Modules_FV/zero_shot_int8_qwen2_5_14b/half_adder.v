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

always #5 clk =~clk; // Clock generation

property p_no_overflow_underflow;
 @(posedge clk) disable iff (!($isunknown(a) || $isunknown(b)))
   ($rose(a) |-> !($stable(a) && $stable(b)));
endproperty

assert property(p_no_overflow_underflow); 

property p_sum_correct;
 @(posedge clk) disable iff (!($isunknown(a) || $isunknown(b)))
   (a === 0 && b === 0 |=> sum === 0);
   (a === 0 && b === 1 |=> sum === 1);
   (a === 1 && b === 0 |=> sum === 1);
   (a === 1 && b === 1 |=> sum === 0);
endproperty

assert property(p_sum_correct);

property p_carry_correct;
 @(posedge clk) disable iff (!($isunknown(a) || $isunknown(b)))
   (a === 0 && b === 0 |=> carry === 0);
   (a === 0 && b === 1 |=> carry === 0);
   (a === 1 && b === 0 |=> carry === 0);
   (a === 1 && b === 1 |=> carry === 1);
endproperty

assert property(p_carry_correct);

endmodule