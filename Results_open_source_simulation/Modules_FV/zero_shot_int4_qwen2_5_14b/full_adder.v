module tb_full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

wire clk;

reg a, b, cin;
wire sum, cout;

full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

always begin
    #5 clk = ~clk;
end

property prop_sum_correct;
    @(posedge clk) disable iff (!reset)
    (a && !b && !cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (!a && b && !cin) |-> sum == 1;
    @(posedge clk) disable iff (!reset)
    (!a && !b && cin) |-> sum == 1;
    @(posedge clk) disable iff (!reset)
    (a && b && !cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (!a && b && cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (a && !b && cin) |-> sum == 0;
    @(posedge clk) disable iff (!reset)
    (a && b && cin) |-> sum == 1;
endproperty

assert property(prop_sum_correct);

property prop_carry_correct;
    @(posedge clk) disable iff (!reset)
    (a && b && !cin) |-> cout == 1;
    @(posedge clk) disable iff (!reset)
    (!a && b && cin) |-> cout == 1;
    @(posedge clk) disable iff (!reset)
    (a && !b && cin) |-> cout == 1;
    @(posedge clk) disable iff (!reset)
    (!a && !b && cin) |-> cout == 0;
    @(posedge clk) disable iff (!reset)
    (!a && !b && !cin) |-> cout == 0;
    @(posedge clk) disable iff (!reset)
    (a && b && cin) |-> cout == 1;
endproperty

assert property(prop_carry_correct);

endmodule