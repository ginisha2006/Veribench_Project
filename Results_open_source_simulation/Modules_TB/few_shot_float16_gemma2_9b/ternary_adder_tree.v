module tb_ternary_adder_tree;
  parameter WIDTH = 16;
  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B, C, D, E;
  // Outputs
  wire [WIDTH-1:0] OUT;

  // Instantiate the Ternary Adder Tree
  ternary_adder_tree uut (
    .A(A), 
    .B(B), 
    .C(C), 
    .D(D), 
    .E(E), 
    .CLK(clk), 
    .OUT(OUT)
  );

  initial begin
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Display the header for the output
    $display("Time	A		B		C		D		E		OUT");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, OUT);

    // Test Cases
    A = 0; B = 0; C = 0; D = 0; E = 0; #10; // Test Case 1: All zeros
    A = 1; B = 1; C = 1; D = 0; E = 0; #10; // Test Case 2: All ones
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b0}}; C = {WIDTH{1'b1}}; D = {WIDTH{1'b0}}; E = {WIDTH{1'b1}}; #10; // Test Case 3: Max + Zero
    A = {WIDTH{1'b0}}; B = {WIDTH{1'b1}}; C = {WIDTH{1'b0}}; D = {WIDTH{1'b1}}; E = {WIDTH{1'b0}}; #10; // Test Case 4: Zero + Max
    // ... Add more test cases as needed

    $finish;
  end
endmodule