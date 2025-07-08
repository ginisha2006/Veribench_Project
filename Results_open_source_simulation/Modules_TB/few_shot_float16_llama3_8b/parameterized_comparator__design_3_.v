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
    // Test Case 1: Equal values
    A = 0; B = 0; #10;
    A = 128; B = 128; #10;
    // Test Case 2: Greater value
    A = 0; B = 1; #10;
    A = 255; B = 254; #10;
    // Test Case 3: Less value
    A = 1; B = 0; #10;
    A = 253; B = 256; #10;
    // Test Case 4: Max value vs min value
    A = {WIDTH{1'b1}}; B = 0; #10;
    // Test Case 5: Mid-value vs mid-value
    A = {WIDTH{1'b0}} | (1 << (WIDTH/2)); B = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Finish the simulation
    $finish;
end
endmodule