module tb_param_multiplier;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Output
wire [2*WIDTH-1:0] product;
// Instantiate the Parameterized Multiplier
param_multiplier #(.WIDTH(WIDTH)) uut (
   .a(a), 
   .b(b), 
   .product(product)
);
initial begin
    // Display the header for the output
    $display("Time	a		b	product");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, a, b, product);
    // Test Case 1: Multiply zero by zero
    a = 0; b = 0; #10;
    // Test Case 2: Multiply zero by one
    a = 0; b = 1; #10;
    // Test Case 3: Multiply one by zero
    a = 1; b = 0; #10;
    // Test Case 4: Multiply one by one
    a = 1; b = 1; #10;
    // Test Case 5: Multiply max by zero
    a = {WIDTH{1'b1}}; b = 0; #10;
    // Test Case 6: Multiply max by one
    a = {WIDTH{1'b1}}; b = 1; #10;
    // Test Case 7: Multiply max by max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 8: Multiply mid-value by mid-value
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Finish the simulation
    $finish;
end
endmodule