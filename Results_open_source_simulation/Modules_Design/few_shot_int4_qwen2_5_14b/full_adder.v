module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire int_carry_a;
    wire int_carry_b;

    half_adder ha_1 (.a(a), .b(b), .sum(sum), .cout(int_carry_a));
    half_adder ha_2 (.a(int_carry_a), .b(cin), .sum(sum), .cout(cout));

    assign {cout, sum} = a ^ b ^ cin ? {int_carry_b, a ^ b ^ cin} : {cin, a ^ b};
    
endmodule