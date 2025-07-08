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
end
initial begin
    // Display the header for the output
    $display("Time	A	B	C	D	E	out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, A, B, C, D, E, out);
    // Apply initial values
    A = 16'd10; B = 16'd20; C = 16'd30; D = 16'd40; E = 16'd50; #20;
    // Change values after some time
    A = 16'd100; B = 16'd200; C = 16'd300; D = 16'd400; E = 16'd500; #20;
    // Edge case with zeros
    A = 16'd0; B = 16'd0; C = 16'd0; D = 16'd0; E = 16'd0; #20;
    // Large value addition
    A = 16'hFFFF; B = 16'hFFFF; C = 16'hFFFF; D = 16'hFFFF; E = 16'hFFFF; #20;
    // Random values
    A = 16'd123; B = 16'd456; C = 16'd789; D = 16'd101; E = 16'd202; #20;
    // Finish the simulation
    $finish;
end
endmodule