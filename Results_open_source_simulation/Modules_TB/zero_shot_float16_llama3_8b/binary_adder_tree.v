module binary_adder_tree_tb();

parameter WIDTH = 16;

reg [WIDTH-1:0] A, B, C, D, E;
reg clk;
wire [WIDTH-1:0] out;

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
	#10 clk = 0; // reset
	#20 clk = 1; // enable clock

	A = 12'h0001;
	B = 12'h0010;
	C = 12'h0100;
	D = 12'h1000;
	E = 12'h0000;

	#50 $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	#100 $display("Test completed");

	#100 $stop;
end

always #5 clk = ~clk;

endmodule