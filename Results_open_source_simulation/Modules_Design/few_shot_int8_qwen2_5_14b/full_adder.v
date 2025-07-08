module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire int_a, int_b;

    xor int_sum(a, b, int_a);
    xor sum(int_a, cin, sum);

    and int_carry1(a, b, int_b);
    and int_carry2(int_a, cin, cout);
    or cout(int_b, cout, cout);
endmodule