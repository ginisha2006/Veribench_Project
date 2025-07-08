module tb_param_multiplier;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Outputs
wire [2*WIDTH-1:0] product;
// Instantiate the Parameterized Multiplier
param_multiplier #(.WIDTH(WIDTH)) uut (
    .a(a), 
    .b(b), 
    .product(product)
);
initial begin
    // Display the header for the output
    $display("Time	a		b		product");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, a, b, product);
    // Test Case 1: Multiply by zero
    a = 5; b = 0; #10;
    // Test Case 2: Multiply by one
    a = 5; b = 1; #10;
    // Test Case 3: Multiply small numbers
    a = 3; b = 7; #10;
    // Test Case 4: Multiply large numbers
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 5: Multiply with overflow
    a = {WIDTH{1'b1}} - 1; b = 2; #10;
    // Finish the simulation
    $finish;
end
endmodule