module full_adder_tb;

reg a, b, cin;
wire sum, cout;

full_adder uut (
   .a(a),
   .b(b),
   .cin(cin),
   .sum(sum),
   .cout(cout)
);

initial begin
    #10; // initial delay
    a = 0; b = 0; cin = 0; // reset inputs
    #10; // wait for reset to settle
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // run for 20 clock cycles
    a = 1; b = 0; cin = 0; // test case: a=1, b=0, cin=0
    #10;
    a = 0; b = 1; cin = 0; // test case: a=0, b=1, cin=0
    #10;
    a = 1; b = 1; cin = 0; // test case: a=1, b=1, cin=0
    #10;
    a = 0; b = 0; cin = 1; // test case: a=0, b=0, cin=1
    #10;
    a = 1; b = 0; cin = 1; // test case: a=1, b=0, cin=1
    #10;
    a = 0; b = 1; cin = 1; // test case: a=0, b=1, cin=1
    #10;
    a = 1; b = 1; cin = 1; // test case: a=1, b=1, cin=1
    #100; // stop simulation after all tests
    $finish;
end

endmodule