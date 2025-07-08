module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
wire w1;
wire w2;

assign {w1,sum} = a ^ b ^ cin;
assign {w2,cout} = a & b | cin & (a ^ b);

endmodule