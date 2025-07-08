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
    $monitor("%0d	%b	%b	%b	%b", $time, A, B, Equal, Greater, Less);
    // Test Case 1: A equals B
    A = 0; B = 0; #10;
    // Test Case 2: A greater than B
    A = 1; B = 0; #10;
    // Test Case 3: A less than B
    A = 0; B = 1; #10;
    // Test Case 4: A equal to max value
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b1}}; #10;
    // Test Case 5: A greater than max value
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b0}}; #10;
    // Test Case 6: A less than min value
    A = {WIDTH{1'b0}}; B = {WIDTH{1'b1}}; #10;
    // Test Case 7: A equal to min value
    A = {WIDTH{1'b0}}; B = {WIDTH{1'b0}}; #10;
    // Finish the simulation
    $finish;
end
endmodule