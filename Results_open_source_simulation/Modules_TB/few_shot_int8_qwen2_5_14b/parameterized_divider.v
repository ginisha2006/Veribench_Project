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
    // Test Case 1: Divide zero by one
    dividend = 0; divisor = 1; #10;
    // Test Case 2: Divide one by one
    dividend = 1; divisor = 1; #10;
    // Test Case 3: Divide max value by one
    dividend = {WIDTH{1'b1}}; divisor = 1; #10;
    // Test Case 4: Divide max value by two
    dividend = {WIDTH{1'b1}}; divisor = 2; #10;
    // Test Case 5: Divide max value by max value
    dividend = {WIDTH{1'b1}}; divisor = {WIDTH{1'b1}}; #10;
    // Test Case 6: Divide mid-value by mid-value
    dividend = {WIDTH{1'b0}} | (1 << (WIDTH/2)); divisor = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Edge case: Divide by zero should be avoided in real scenarios but tested here for completeness
    dividend = 1; divisor = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule