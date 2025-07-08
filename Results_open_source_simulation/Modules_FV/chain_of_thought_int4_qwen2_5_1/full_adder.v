module tb_full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

logic clk;
always begin
    #5 clk = ~clk;
end

property correct_sum;
    @(posedge clk) disable iff (!reset)
    (a && !b && !cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (!a && b && !cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (!a && !b && cin) |-> sum == 1;
    @(posedge clk) disable iff (!reset)
    (a && b && !cin) |-> sum == !a;
    @(posedge clk) disable iff (!reset)
    (!a && b && cin) |-> sum == b;
    @(posedge clk) disable iff (!reset)
    (a && !b && cin) |-> sum == a;
    @(posedge clk) disable iff (!reset)
    (a && b && cin) |-> sum == !(a & b);
endproperty

assert property(correct_sum);

property correct_carry_out;
    @(posedge clk) disable iff (!reset)
    (a && b && !cin) |-> cout == a & b;
    @(posedge clk) disable iff (!reset)
    (!a && b && cin) |-> cout == b;
    @(posedge clk) disable iff (!reset)
    (a && !b && cin) |-> cout == a;
    @(posedge clk) disable iff (!reset)
    (a && b && cin) |-> cout == a | b | cin;
endproperty

assert property(correct_carry_out);

endmodule