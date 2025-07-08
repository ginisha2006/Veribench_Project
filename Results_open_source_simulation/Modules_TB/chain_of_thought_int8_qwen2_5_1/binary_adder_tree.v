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
		#0 $dumpfile("wave.vcd");
		$dumpvars(0, tb_binary_adder_tree);
		
		A = 16'b0; B = 16'b0; C = 16'b0; D = 16'b0; E = 16'b0;
		clk = 0;
		#10
		
		for(int i=0; i<10; i=i+1) begin
			A = $random % 65536;
			B = $random % 65536;
			C = $random % 65536;
			D = $random % 65536;
			E = $random % 65536;
			
			#10
			
			clk = ~clk;
			#5
			clk = ~clk;
			#5
		end
		
		#10
		$finish;
	end
	
	initial begin
		$monitor($time," ns: A=%b, B=%b, C=%b, D=%b, E=%b, out=%b", A, B, C, D, E, out);
	end
	
endmodule