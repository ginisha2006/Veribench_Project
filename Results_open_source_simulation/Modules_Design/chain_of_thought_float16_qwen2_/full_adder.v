module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire w1, w2;
    
    xor u1 (w1, a, b);
    xor u2 (sum, w1, cin);
    and u3 (w2, a, b);
    and u4 (cout, w2, cin);
    or u5 (cout, w1, cout);
endmodule