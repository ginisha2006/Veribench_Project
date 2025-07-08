module tb_half_adder;
// Inputs
reg a;
reg b;
// Outputs
wire sum;
wire carry;
// Instantiate the Half Adder
half_adder uut (
   .a(a), 
   .b(b), 
   .sum(sum), 
   .carry(carry)
);
initial begin
    // Display the header for the output
    $display("Time	a	b	sum	carry");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, a, b, sum, carry);
    // Test all possible input combinations
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule