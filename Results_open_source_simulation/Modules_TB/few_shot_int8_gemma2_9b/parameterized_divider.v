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
    $display("Time	Dividend	Divisor	Quotient	Remainder");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, dividend, divisor, quotient, remainder);
    // Test Case 1: Divide by 1
    dividend = 10; divisor = 1; #10;
    // Test Case 2: Divide by 2
    dividend = 10; divisor = 2; #10;
    // Test Case 3: Divide by 4
    dividend = 10; divisor = 4; #10;
    // Test Case 4: Divide by 8
    dividend = 10; divisor = 8; #10;
    // Test Case 5: Divide by a value close to dividend
    dividend = 127; divisor = 126; #10;
    // Test Case 6: Divide by 0 (should result in error)
    dividend = 10; divisor = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule