module tb_param_comparator;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
// Outputs
wire Equal;
wire Greater;
wire Less;
// Instantiate the Parameterized Comparator
param_comparator #(.WIDTH(WIDTH)) uut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
);
initial begin
    // Display the header for the output
    $display("Time	A	B	Equal	Greater	Less");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, A, B, Equal, Greater, Less);
    // Test Case 1: A equal to B
    A = 5'd3; B = 5'd3; #10;
    // Test Case 2: A greater than B
    A = 5'd5; B = 5'd3; #10;
    // Test Case 3: A less than B
    A = 5'd3; B = 5'd5; #10;
    // Test Case 4: A max value, B min value
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b0}}; #10;
    // Test Case 5: A min value, B max value
    A = {WIDTH{1'b0}}; B = {WIDTH{1'b1}}; #10;
    // Test Case 6: A mid-value, B mid-value
    A = {WIDTH{1'b0}} | (1 << (WIDTH/2)); B = {WIDTH{1'b0}} | (1 << (WIDTH/2) - 1); #10;
    // Finish the simulation
    $finish;
end
endmodule