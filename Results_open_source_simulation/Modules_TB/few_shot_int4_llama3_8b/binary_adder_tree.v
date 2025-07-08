module tb_binary_adder_tree;
// Inputs
reg [15:0] A;
reg [15:0] B;
reg [15:0] C;
reg [15:0] D;
reg [15:0] E;
reg clk;
// Outputs
wire [15:0] out;
// Instantiate the Binary Adder Tree
binary_adder_tree uut (
   .A(A), 
   .B(B), 
   .C(C), 
   .D(D), 
   .E(E), 
   .clk(clk), 
   .out(out)
);
initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
    // Display the header for the output
    $display("Time	A	B	C	D	E	out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%h	%h	%h	%h	%h", $time, A, B, C, D, E, out);
    // Test Case 1: Add two numbers
    A = 16'd10; B = 16'd20; #100;
    // Test Case 2: Add three numbers
    A = 16'd30; B = 16'd40; C = 16'd50; #100;
    // Test Case 3: Add four numbers
    A = 16'd60; B = 16'd70; C = 16'd80; D = 16'd90; #100;
    // Finish the simulation
    $finish;
end
endmodule