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
    #10;
    $display("Testing with a=0, b=0, cin=0");
    #10;
    assert(sum == 0); assert(cout == 0);
    
    a = 0; b = 0; cin = 1; // testing carry-in
    #10;
    $display("Testing with a=0, b=0, cin=1");
    #10;
    assert(sum == 1); assert(cout == 1);
    
    a = 0; b = 1; cin = 0; // testing bit-wise addition
    #10;
    $display("Testing with a=0, b=1, cin=0");
    #10;
    assert(sum == 1); assert(cout == 0);
    
    a = 0; b = 1; cin = 1; // testing carry-out
    #10;
    $display("Testing with a=0, b=1, cin=1");
    #10;
    assert(sum == 0); assert(cout == 1);
    
    a = 1; b = 0; cin = 0; // testing bit-wise addition
    #10;
    $display("Testing with a=1, b=0, cin=0");
    #10;
    assert(sum == 1); assert(cout == 0);
    
    a = 1; b = 0; cin = 1; // testing carry-out
    #10;
    $display("Testing with a=1, b=0, cin=1");
    #10;
    assert(sum == 0); assert(cout == 1);
    
    a = 1; b = 1; cin = 0; // testing bit-wise addition
    #10;
    $display("Testing with a=1, b=1, cin=0");
    #10;
    assert(sum == 0); assert(cout == 1);
    
    a = 1; b = 1; cin = 1; // testing all-ones input
    #10;
    $display("Testing with a=1, b=1, cin=1");
    #10;
    assert(sum == 1); assert(cout == 1);
    
    $finish;
end

always @(*) begin
    $monitor($time, "a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
end

endmodule