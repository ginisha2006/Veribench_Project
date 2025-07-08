module half_adder_tb;

reg a, b;

wire sum, carry;

half_adder uut (a, b, sum, carry);

initial begin

#10 a = 0; b = 0; #20;

$monitor($time, "a=%b, b=%b, sum=%b, carry=%b\n", a, b, sum, carry);

#10 a = 1; b = 0; #20;

#10 a = 0; b = 1; #20;

#10 a = 1; b = 1; #20;

#100 $finish;

end

endmodule