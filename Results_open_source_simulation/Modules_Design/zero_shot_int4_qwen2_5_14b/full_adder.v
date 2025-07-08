module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
wire w1, w2;

half_adder ha1(a, b, w1, cout);
half_adder ha2(w1, cin, sum, w2);

assign cout = w2 | (w1 & cin);

endmodule