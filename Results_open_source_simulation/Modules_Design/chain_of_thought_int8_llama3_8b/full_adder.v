module full_adder(a, b, cin, sum, cout);
input wire a;
input wire b;
input wire cin;
output wire sum;
output wire cout;

assign sum = a ^ b ^ cin;
assign cout = & (a & b) | (a & cin) | (b & cin);

endmodule