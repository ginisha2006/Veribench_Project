module tb_param_adder;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Outputs
wire [WIDTH-1:0] sum;
wire carry;
// Instantiate the Parameterized Adder
param_adder #(.WIDTH(WIDTH)) uut (
   .a(a), 
   .b(b), 
   .sum(sum), 
   .carry(carry)
);
initial begin
    // Display the header for the output
    $display("Time	a		b		sum		carry");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, a, b, sum, carry);
    // Test Case 1: Add zero + zero
    a = 0; b = 0; #10;    
    // Test Case 2: Add zero + one
    a = 0; b = 1; #10;
    // Test Case 3: Add one + one
    a = 1; b = 1; #10;
    // Test Case 4: Add max + zero
    a = {WIDTH{1'b1}}; b = 0; #10;
    // Test Case 5: Add max + one
    a = {WIDTH{1'b1}}; b = 1; #10;
    // Test Case 6: Add max + max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 7: Add mid-value + mid-value
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Test Case 8: Add mid-value + zero
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = 0; #10;
    // Test Case 9: Add mid-value + one
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = 1; #10;
    // Test Case 10: Add mid-value + max
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = {WIDTH{1'b1}}; #10;
    // Finish the simulation
    $finish;
end
endmodule