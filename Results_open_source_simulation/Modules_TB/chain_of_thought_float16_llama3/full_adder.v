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
    #10; // delay for setup
    a = 0; b = 0; cin = 0; // initial values
    #5; // wait for some time
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #10; a = 1; b = 0; cin = 0; // test case 1
    #5; 
    #10; a = 0; b = 1; cin = 0; // test case 2
    #5; 
    #10; a = 1; b = 1; cin = 0; // test case 3
    #5; 
    #10; a = 0; b = 0; cin = 1; // test case 4
    #5; 
    #10; a = 1; b = 0; cin = 1; // test case 5
    #5; 
    #10; a = 0; b = 1; cin = 1; // test case 6
    #5; 
    #10; a = 1; b = 1; cin = 1; // test case 7
    #100; // end of test
    $finish;
end

always #20; // clock pulse
#10; #10; // 20 ns period

endmodule