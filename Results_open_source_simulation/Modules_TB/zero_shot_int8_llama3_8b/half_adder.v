module half_adder_tb;

reg a, b;
wire sum, carry;

half_adder uut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

initial begin
    #20; // wait for 20 time units
    a <= 0; b <= 0; // initial values
    #10; // wait for 10 time units
    a <= 1; b <= 0; // test case: a=1, b=0
    #10; // wait for 10 time units
    a <= 0; b <= 1; // test case: a=0, b=1
    #10; // wait for 10 time units
    a <= 1; b <= 1; // test case: a=1, b=1
    #10; // wait for 10 time units
    a <= 0; b <= 0; // test case: a=0, b=0
    #100; // wait for 100 time units
    $monitor($time, "a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
end

always #5 $display("Testbench started");
always #10000000 $display("Testbench finished");

endmodule