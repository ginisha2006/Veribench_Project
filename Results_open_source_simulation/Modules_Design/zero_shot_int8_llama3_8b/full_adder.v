module full_adder(a, b, cin, sum, cout);
input wire a;
input wire b;
input wire cin;
output reg sum;
output reg cout;

assign sum = a ^ b ^ cin;
assign cout = & (a & b) | (a & cin) | (b & cin);

endmodule