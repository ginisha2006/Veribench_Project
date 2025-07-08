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
    #10; // delay for setup
    a = 0; b = 0; // reset inputs
    #10;
    $display("Initial state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // toggle inputs
    a = 1; b = 0;
    #10;
    $display("State after toggling a: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // toggle inputs again
    a = 0; b = 1;
    #10;
    $display("State after toggling b: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // toggle both inputs
    a = 1; b = 1;
    #10;
    $display("State after toggling both: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #100; // hold inputs high
    a = 1; b = 1;
    #100;
    $display("Holding inputs high: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #100; // reset inputs
    a = 0; b = 0;
    #10;
    $display("Final state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    $finish;
end

always #5 $monitor($time, "a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);

endmodule