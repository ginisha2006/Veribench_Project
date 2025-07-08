module full_adder_tb();

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
    a <= 0; b <= 0; cin <= 0; // initial values
    #20; // wait for some time
    a <= 1; b <= 0; cin <= 0; // test case 1
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 0; b <= 1; cin <= 0; // test case 2
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 1; b <= 1; cin <= 0; // test case 3
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 0; b <= 0; cin <= 1; // test case 4
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 1; b <= 0; cin <= 1; // test case 5
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 0; b <= 1; cin <= 1; // test case 6
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #20; // wait for some time
    a <= 1; b <= 1; cin <= 1; // test case 7
    @(posedge cout); // wait for posedge cout
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    #100; // wait for some time
    $finish; // finish simulation
end

endmodule