module tb_param_divider;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
// Outputs
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;
// Instantiate the Parameterized Divider
param_divider #(.WIDTH(WIDTH)) uut (
   .dividend(dividend), 
   .divisor(divisor), 
   .quotient(quotient), 
   .remainder(remainder)
);
initial begin
    // Display the header for the output
    $display("Time	dividend	divisor	quotient	remainder");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, dividend, divisor, quotient, remainder);
    // Test Case 1: Divide by 1
    dividend = 16; divisor = 1; #10;
    // Test Case 2: Divide by 2
    dividend = 16; divisor = 2; #10;
    // Test Case 3: Divide by 3
    dividend = 15; divisor = 3; #10;
    // Test Case 4: Divide by 4
    dividend = 12; divisor = 4; #10;
    // Test Case 5: Divide by 5
    dividend = 20; divisor = 5; #10;
    // Test Case 6: Divide by 6
    dividend = 24; divisor = 6; #10;
    // Test Case 7: Divide by 7
    dividend = 21; divisor = 7; #10;
    // Test Case 8: Divide by 8
    dividend = 16; divisor = 8; #10;
    // Test Case 9: Divide by 9
    dividend = 27; divisor = 9; #10;
    // Test Case 10: Divide by 10
    dividend = 30; divisor = 10; #10;
    // Finish the simulation
    $finish;
end
endmodule