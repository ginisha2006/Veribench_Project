module tb_ternary_adder_tree;
// Parameters
parameter WIDTH = 16;
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
    // Initialize clock
    CLK = 0;
    forever #5 CLK = ~CLK;
end
initial begin
    // Display the header for the output
    $display("Time	A	B	C	D	E	OUT");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, OUT);
    // Apply initial values
    A = 0; B = 0; C = 0; D = 0; E = 0; #20;
    // Test case 1: All zeros
    A = 0; B = 0; C = 0; D = 0; E = 0; #20;
    // Test case 2: Single bit set in each input
    A = 1; B = 0; C = 0; D = 0; E = 0; #20;
    A = 0; B = 1; C = 0; D = 0; E = 0; #20;
    A = 0; B = 0; C = 1; D = 0; E = 0; #20;
    A = 0; B = 0; C = 0; D = 1; #20;
    A = 0; B = 0; C = 0; D = 0; E = 1; #20;
    // Test case 3: Full range addition
    A = 'hFFFF; B = 'hFFFF; C = 'hFFFF; D = 'hFFFF; E = 'hFFFF; #20;
    // Test case 4: Random values
    A = 16'hABCD; B = 16'hDEFF; C = 16'h1234; D = 16'h5678; E = 16'h9ABC; #20;
    // Finish the simulation
    $finish;
end
endmodule