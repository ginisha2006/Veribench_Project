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
		#10; // Initial delay before starting tests
		A = 16'd1024;
		B = 16'd512;
		C = 16'd256;
		D = 16'd128;
		E = 16'd64;
		clk = 0;
	end
	
	always #5 clk = ~clk;
	
	initial begin
		repeat(10) @(negedge clk); // Wait for some clock cycles
		
		$monitor("At time %t, A=%d, B=%d, C=%d, D=%d, E=%d, out=%d", $time, A, B, C, D, E, out);
		
		A = 16'hFFFF;
		B = 16'hFFFE;
		C = 16'hFFF0;
		D = 16'hFFF1;
		E = 16'hFFF2;
		@(negedge clk);
		
		A = 16'h0000;
		B = 16'h0001;
		C = 16'h0002;
		D = 16'h0003;
		E = 16'h0004;
		@(negedge clk);
		
		A = 16'h7F00;
		B = 16'h007F;
		C = 16'hF007;
		D = 16'h0F00;
		E = 16'h00F0;
		@(negedge clk);
		
		#100; // End of test after some more clock cycles
		$finish;
	end
endmodule