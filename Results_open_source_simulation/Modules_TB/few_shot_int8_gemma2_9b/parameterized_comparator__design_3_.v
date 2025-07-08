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
    $display("Time	A		B	Equal	Greater	Less");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, A, B, Equal, Greater, Less);
    // Test Case 1: Equal values
    A = 8'b00000000; B = 8'b00000000; #10;
    // Test Case 2: A greater than B
    A = 8'b11111111; B = 8'b00000000; #10;
    // Test Case 3: A less than B
    A = 8'b00000000; B = 8'b11111111; #10;
    // Test Case 4: Different values
    A = 8'b01010101; B = 8'b10101010; #10;
    // Finish the simulation
    $finish;
end
endmodule