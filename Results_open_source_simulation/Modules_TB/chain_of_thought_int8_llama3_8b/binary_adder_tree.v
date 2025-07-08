module binary_adder_tree_tb();

parameter CLOCK_PERIOD = 10; // in ns

reg [15:0] A, B, C, D, E;
reg clk;
wire [15:0] out;

initial begin
	$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	A = 16'h0001;
	B = 16'h0002;
	C = 16'h0003;
	D = 16'h0004;
	E = 16'h0005;
	#(CLOCK_PERIOD*2) clk = 1'b1;
	#CLOCK_PERIOD clk = 1'b0;
	repeat (100) begin
		A = A + 1;
		B = B + 1;
		C = C + 1;
		D = D + 1;
		E = E + 1;
		#CLOCK_PERIOD clk = ~clk;
	end
end

initial begin
	clk = 1'b0;
	forever #CLOCK_PERIOD clk = ~clk;
end

endmodule