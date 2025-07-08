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
    // Initialize the clock
    CLK = 0;
    forever begin
        #10;  // Clock period
        CLK = ~CLK;  // Toggle the clock
    end
    // Display the header for the output
    $display("Time	A	B	C	D	E	OUT");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, A, B, C, D, E, OUT);
    // Test Case 1: Add zero + zero + zero
    A = 0; B = 0; C = 0; D = 0; E = 0; #20;
    // Test Case 2: Add zero + zero + one
    A = 0; B = 0; C = 1; D = 0; E = 0; #20;
    // Test Case 3: Add zero + one + one
    A = 0; B = 1; C = 1; D = 0; E = 0; #20;
    // Test Case 4: Add one + one + one
    A = 1; B = 1; C = 1; D = 0; E = 0; #20;
    // Test Case 5: Add max + max + max
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b1}}; C = {WIDTH{1'b1}}; D = 0; E = 0; #20;
    // Finish the simulation
    $finish;
end
endmodule