module binary_adder_tree_tb();

parameter PERIOD = 10; // in ns

reg clk;
wire [15:0] A, B, C, D, E, out;

initial begin
	#(PERIOD*5) clk = 1'b0;
	forever #PERIOD clk = ~clk;
end

initial begin
	A = 16'h0001;
	B = 16'h0002;
	C = 16'h0003;
	D = 16'h0004;
	E = 16'h0005;
	@(posedge clk);
	$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
end

endmodule