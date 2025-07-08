module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    
wire w1, w2;

xor x1(sum, a, b);
xor x2(w1, b, cin);

and y1(w2, a, b);
and y2(cout, w1, a);
or o1(cout, w2, cin);

endmodule