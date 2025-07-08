module tb_binary_adder_tree;
// Inputs
reg [15:0] A;
reg [15:0] B;
reg [15:0] C;
reg [15:0] D;
reg [15:0] E;
reg        clk;
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
    // Initialize inputs
    A = 16'd10; B = 16'd20; C = 16'd30; D = 16'd40; E = 16'd50;
    clk = 0;
    // Display the header for the output
    $display("Time	A	B	C	D	E	out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, out);
    // Clock generation
    forever #5 clk = ~clk;
end
initial begin
    // Wait for some time before changing inputs
    #20;
    // Change inputs after initial state
    A = 16'd5; B = 16'd15; C = 16'd25; D = 16'd35; E = 16'd45;
    #20;
    // Final change in inputs
    A = 16'd1; B = 16'd2; C = 16'd3; D = 16'd4; E = 16'd5;
    #20;
    // Finish the simulation
    $finish;
end
endmodule