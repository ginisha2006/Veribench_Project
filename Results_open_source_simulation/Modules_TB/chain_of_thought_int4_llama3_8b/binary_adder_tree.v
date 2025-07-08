module binary_adder_tree_tb();

parameter PERIOD = 10; // clock period in ns

reg clk;
wire [15:0] A, B, C, D, E, out;

initial begin
	#(PERIOD*5) clk = 1'b0; // initial state
	forever #PERIOD clk = ~clk; // toggle clock
end

initial begin
	A = 16'h0001; // set initial values for inputs
	B = 16'h0010;
	C = 16'h0100;
	D = 16'h1000;
	E = 16'h0000;
	out = 16'bx; // initialize output

	$monitor ($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	
	@(posedge clk); // wait for first clock cycle
	$display("Initial values: A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	
	A = 16'h1111; // change input values
	B = 16'h2222;
	C = 16'h3333;
	D = 16'h4444;
	E = 16'h5555;
	
	@(posedge clk); // wait for second clock cycle
	$display("Updated values: A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	
	A = 16'h6666; // change input values again
	B = 16'h7777;
	C = 16'h8888;
	D = 16'h9999;
	E = 16'haaaa;
	
	@(posedge clk); // wait for third clock cycle
	$display("Final values: A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	
	#(PERIOD*10); // wait for some time before stopping simulation
	$finish;
end

endmodule