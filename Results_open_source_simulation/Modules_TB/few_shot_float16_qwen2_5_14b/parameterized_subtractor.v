module tb_param_subtractor;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Outputs
wire [WIDTH-1:0] diff;
wire borrow;
// Instantiate the Parameterized Subtractor
param_subtractor #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
);
initial begin
    // Display the header for the output
    $display("Time	a		b	diff	borrow");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, a, b, diff, borrow);
    // Test Case 1: Subtract zero from zero
    a = 0; b = 0; #10;
    // Test Case 2: Subtract zero from one
    a = 1; b = 0; #10;
    // Test Case 3: Subtract one from one
    a = 1; b = 1; #10;
    // Test Case 4: Subtract max from zero
    a = {WIDTH{1'b1}}; b = 0; #10;
    // Test Case 5: Subtract max from one
    a = {WIDTH{1'b1}}; b = 1; #10;
    // Test Case 6: Subtract max from max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 7: Subtract mid-value from mid-value
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Test Case 8: Subtract zero from max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 9: Subtract one from max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b0}} | (1 << (WIDTH-1)); #10;
    // Finish the simulation
    $finish;
end
endmodule