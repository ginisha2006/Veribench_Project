module tb_ternary_adder_tree;

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;
logic CLK;
logic [WIDTH-1:0] OUT;

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
	#10; // delay for setup
	A = 8'h0001;
	B = 8'h0010;
	C = 8'h0100;
	D = 8'h1000;
	E = 8'h0000;
	CLK = 1'b0;
	fork
		#20; // clock pulse
		CLK = ~CLK;
	join_any
	end

always @(posedge CLK) begin
	$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);
	end

endmodule