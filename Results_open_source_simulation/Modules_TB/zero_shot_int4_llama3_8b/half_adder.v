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
    a <= 0; b <= 0; // initial values
    #20; // wait for some time
    $display("Initial state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // change inputs
    a <= 1; b <= 0;
    #20; // wait for some time
    $display("New state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // change inputs again
    a <= 0; b <= 1;
    #20; // wait for some time
    $display("New state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #10; // change inputs again
    a <= 1; b <= 1;
    #20; // wait for some time
    $display("New state: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    #100; // wait for some more time
    $finish; // end simulation
end

always @(posedge clock) begin
    #5; // delay for observation
    $monitor("Time: %t, a=%b, b=%b, sum=%b, carry=%b", $time, a, b, sum, carry);
end

endmodule