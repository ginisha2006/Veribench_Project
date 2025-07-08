module tb_binary_adder_tree;
// Inputs
reg [15:0] A;
reg [15:0] B;
reg [15:0] C;
reg [15:0] D;
reg [15:0] E;
input clk;
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
// Clock generation
reg clk_signal;
always #5 clk_signal = ~clk_signal;
assign clk = clk_signal;
initial begin
    // Display the header for the output
    $display("Time	A	B	C	D	E	out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, out);
    // Initialize signals
    A = 16'd0; B = 16'd0; C = 16'd0; D = 16'd0; E = 16'd0; #10;
    // Test case 1: All zeros
    A = 16'd0; B = 16'd0; C = 16'd0; D = 16'd0; E = 16'd0; #10;
    // Test case 2: Incremental values
    A = 16'd1; B = 16'd2; C = 16'd3; D = 16'd4; E = 16'd5; #10;
    // Test case 3: Max values
    A = 16'hFFFF; B = 16'hFFFF; C = 16'hFFFF; D = 16'hFFFF; E = 16'hFFFF; #10;
    // Test case 4: Random values
    A = 16'hABCD; B = 16'hDEFF; C = 16'h1234; D = 16'h5678; E = 16'h9ABC; #10;
    // Finish the simulation
    $finish;
end
endmodule