module tb_binary_adder_tree;
	reg	[15:0]	A, B, C, D, E;
	reg	clk;
	wire	[15:0]	out;

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
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		A = 16'd10;	B = 16'd20;	C = 16'd30;	D = 16'd40;	E = 16'd50;
		#10;
		A = 16'd100;	B = 16'd200;	C = 16'd300;	D = 16'd400;	E = 16'd500;
		#10;
		A = 16'hFFFF;	B = 16'hFFFE;	C = 16'hFFF0;	D = 16'hFFF8;	E = 16'hFFF7;
		#10;
		A = 16'b0;	B = 16'b0;	C = 16'b0;	D = 16'b0;	E = 16'b0;
		#10;
		A = 16'd-10;	B = 16'd-20;	C = 16'd-30;	D = 16'd-40;	E = 16'd-50;
		#10;
		$stop;
	end

	initial begin
		$monitor($time, " ns: A=%d, B=%d, C=%d, D=%d, E=%d, out=%d", A, B, C, D, E, out);
	end
endmodule