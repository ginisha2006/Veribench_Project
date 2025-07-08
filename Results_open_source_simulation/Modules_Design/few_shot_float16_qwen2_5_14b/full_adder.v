module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire int_a = a ^ b; 
    wire int_b = a & b;

    assign sum = int_a ^ cin;
    assign cout = (int_a & cin) | int_b;
endmodule