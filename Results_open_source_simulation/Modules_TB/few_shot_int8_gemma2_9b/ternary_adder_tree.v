module tb_ternary_adder_tree;
// Parameter
parameter WIDTH = 16;
// Inputs
reg CLK;
reg [WIDTH-1:0] A, B, C, D, E;
// Outputs
wire [WIDTH-1:0] OUT;
// Instantiate the Ternary Adder Tree
ternary_adder_tree dut (
    .A(A), 
    .B(B), 
    .C(C), 
    .D(D), 
    .E(E), 
    .CLK(CLK), 
    .OUT(OUT)
);
initial begin
    // Clock generation
    CLK = 0;
    forever #5 CLK = ~CLK;
    // Stimulus
    A = 8'h0F; B = 8'h1A; C = 8'h05; D = 8'h3B; E = 8'h02; #10;
    A = 8'hAA; B = 8'hBB; C = 8'hCC; D = 8'hDD; E = 8'hEE; #10;
    A = 8'hFF; B = 8'h00; C = 8'h00; D = 8'h00; E = 8'h00; #10;
    // ... add more test cases as needed
end
initial begin
    // Output monitoring
    $display("Time	A	B	C	D	E	OUT");
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, OUT);
    $finish;
end
endmodule