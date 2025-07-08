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
    dividend = 8'hFF; divisor = 8'h01; #10;
    // Test Case 2: Divide by 2
    dividend = 8'hAA; divisor = 8'h02; #10;
    // Test Case 3: Divide by 4
    dividend = 8'h55; divisor = 8'h04; #10;
    // Test Case 4: Divide by 8
    dividend = 8'hEE; divisor = 8'h08; #10;
    // Test Case 5: Divide by a larger number
    dividend = 8'h1F; divisor = 8'h07; #10;
    // Test Case 6: Divide by zero
    dividend = 8'h00; divisor = 8'h00; #10; // This will result in an error
    // Finish the simulation
    $finish;
end
endmodule