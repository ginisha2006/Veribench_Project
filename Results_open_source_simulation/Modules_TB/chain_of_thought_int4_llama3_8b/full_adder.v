timescale 1ns / 100ps;

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
    $display("Initial state: a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);

    // Test case 1: all inputs are 0
    a <= 0; b <= 0; cin <= 0;
    #20; // wait for some time
    $display("Test case 1: a=0, b=0, cin=0");
    $display("Expected sum=0, cout=0");
    assert(sum == 0);
    assert(cout == 0);

    // Test case 2: all inputs are 1
    a <= 1; b <= 1; cin <= 1;
    #20; // wait for some time
    $display("Test case 2: a=1, b=1, cin=1");
    $display("Expected sum=1, cout=1");
    assert(sum == 1);
    assert(cout == 1);

    // Test case 3: a=0, b=1, cin=0
    a <= 0; b <= 1; cin <= 0;
    #20; // wait for some time
    $display("Test case 3: a=0, b=1, cin=0");
    $display("Expected sum=1, cout=0");
    assert(sum == 1);
    assert(cout == 0);

    // Test case 4: a=1, b=0, cin=0
    a <= 1; b <= 0; cin <= 0;
    #20; // wait for some time
    $display("Test case 4: a=1, b=0, cin=0");
    $display("Expected sum=1, cout=0");
    assert(sum == 1);
    assert(cout == 0);

    // Test case 5: a=0, b=1, cin=1
    a <= 0; b <= 1; cin <= 1;
    #20; // wait for some time
    $display("Test case 5: a=0, b=1, cin=1");
    $display("Expected sum=1, cout=1");
    assert(sum == 1);
    assert(cout == 1);

    // Test case 6: a=1, b=0, cin=1
    a <= 1; b <= 0; cin <= 1;
    #20; // wait for some time
    $display("Test case 6: a=1, b=0, cin=1");
    $display("Expected sum=0, cout=1");
    assert(sum == 0);
    assert(cout == 1);

    // Test case 7: a=1, b=1, cin=0
    a <= 1; b <= 1; cin <= 0;
    #20; // wait for some time
    $display("Test case 7: a=1, b=1, cin=0");
    $display("Expected sum=0, cout=1");
    assert(sum == 0);
    assert(cout == 1);

    // Test case 8: a=0, b=0, cin=1
    a <= 0; b <= 0; cin <= 1;
    #20; // wait for some time
    $display("Test case 8: a=0, b=0, cin=1");
    $display("Expected sum=1, cout=1");
    assert(sum == 1);
    assert(cout == 1);

    // Test case 9: a=1, b=1, cin=1
    a <= 1; b <= 1; cin <= 1;
    #20; // wait for some time
    $display("Test case 9: a=1, b=1, cin=1");
    $display("Expected sum=1, cout=1");
    assert(sum == 1);
    assert(cout == 1);

    // Test case 10: a=0, b=0, cin=0
    a <= 0; b <= 0; cin <= 0;
    #20; // wait for some time
    $display("