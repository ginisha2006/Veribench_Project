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
    // Test Case 1: Divide by zero
    dividend = 16; divisor = 0; #10;
    // Test Case 2: Divide by one
    dividend = 16; divisor = 1; #10;
    // Test Case 3: Divide by two
    dividend = 16; divisor = 2; #10;
    // Test Case 4: Divide by four
    dividend = 16; divisor = 4; #10;
    // Test Case 5: Divide by eight
    dividend = 16; divisor = 8; #10;
    // Test Case 6: Divide by sixteen
    dividend = 16; divisor = 16; #10;
    // Test Case 7: Divide by maximum value
    dividend = {WIDTH{1'b1}}; divisor = {WIDTH{1'b1}}; #10;
    // Test Case 8: Divide by minimum value
    dividend = {WIDTH{1'b0}}; divisor = {WIDTH{1'b1}}; #10;
    // Finish the simulation
    $finish;
end
endmodule