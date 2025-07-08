module tb_ternary_adder_tree;
// Parameter
parameter WIDTH = 16;  // Default width is 16 bits
// Inputs
reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
reg [WIDTH-1:0] C;
reg [WIDTH-1:0] D;
reg [WIDTH-1:0] E;
reg CLK;
// Outputs
wire [WIDTH-1:0] OUT;
// Instantiate the Ternary Adder Tree
ternary_adder_tree uut (
   .A(A), 
   .B(B), 
   .C(C), 
   .D(D), 
   .E(E), 
   .CLK(CLK), 
   .OUT(OUT)
);
initial begin
    // Display the header for the output
    $display("Time	A	B	C	D	E	OUT");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, A, B, C, D, E, OUT);
    // Test Case 1: Add three numbers
    A = 0; B = 1; C = 2; D = 3; E = 4; #100; // Wait for 100 clock cycles
    // Test Case 2: Add two numbers with carry
    A = 0; B = 1; C = 0; D = 1; E = 0; #100; // Wait for 100 clock cycles
    // Test Case 3: Add one number with carry
    A = 0; B = 0; C = 0; D = 0; E = 1; #100; // Wait for 100 clock cycles
    // Test Case 4: Add zero
    A = 0; B = 0; C = 0; D = 0; E = 0; #100; // Wait for 100 clock cycles
    // Finish the simulation
    $finish;
end
endmodule