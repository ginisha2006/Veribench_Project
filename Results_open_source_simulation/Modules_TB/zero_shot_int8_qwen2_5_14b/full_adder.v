module tb_full_adder;
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
        // Initialize inputs
        a = 0; b = 0; cin = 0;
        #10;
        
        // Test case: All zeros
        a = 0; b = 0; cin = 0;
        #10;
        
        // Test case: A=1, B=0, Cin=0
        a = 1; b = 0; cin = 0;
        #10;
        
        // Test case: A=0, B=1, Cin=0
        a = 0; b = 1; cin = 0;
        #10;
        
        // Test case: A=0, B=0, Cin=1
        a = 0; b = 0; cin = 1;
        #10;
        
        // Test case: A=1, B=1, Cin=0
        a = 1; b = 1; cin = 0;
        #10;
        
        // Test case: A=1, B=0, Cin=1
        a = 1; b = 0; cin = 1;
        #10;
        
        // Test case: A=0, B=1, Cin=1
        a = 0; b = 1; cin = 1;
        #10;
        
        // Test case: A=1, B=1, Cin=1
        a = 1; b = 1; cin = 1;
        #10;
        
        // Monitor outputs for all tests
        $monitor("At time %t: a=%b, b=%b, cin=%b, sum=%b, cout=%b", $time, a, b, cin, sum, cout);
    end
endmodule