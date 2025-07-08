module tb_true_dpram_sclk;

parameter WIDTH = 8;
parameter DEPTH = 64;

reg [WIDTH-1:0] data_a, data_b;
reg [DEPTH-1:0] addr_a, addr_b;
reg we_a, we_b;
reg clk;
wire [WIDTH-1:0] q_a, q_b;

true_dpram_sclk #(.WIDTH(WIDTH),.DEPTH(DEPTH)) dut (
	.data_a(data_a),
	.data_b(data_b),
	.addr_a(addr_a),
	.addr_b(addr_b),
	.we_a(we_a),
	.we_b(we_b),
	.clk(clk),
	.q_a(q_a),
	.q_b(q_b)
);

initial begin
	$monitor($time, "data_a=%b, data_b=%b, addr_a=%d, addr_b=%d, we_a=%b, we_b=%b, clk=%b, q_a=%b, q_b=%b", data_a, data_b, addr_a, addr_b, we_a, we_b, clk, q_a, q_b);

	data_a = 0; data_b = 0; addr_a = 0; addr_b = 0; we_a = 0; we_b = 0; clk = 0; #10;
	fork
		clk = 1; #5;
		#10;
		clk = 0; #5;
		#10;
		clk = 1; #5;
		#10;
		we_a = 1; addr_a = 3; data_a = 12; #10;
		we_a = 0; addr_a = 2; #10;
		we_b = 1; addr_b = 4; data_b = 34; #10;
		we_b = 0; addr_b = 1; #10;
		we_a = 1; addr_a = 5; data_a = 56; #10;
		we_a = 0; addr_a = 3; #10;
		we_b = 1; addr_b = 6; data_b = 78; #10;
		we_b = 0; addr_b = 4; #10;
		clk = 0; #10;
		#10;
		clk = 1; #5;
		#10;
		we_a = 1; addr_a = 7; data_a = 90; #10;
		we_a = 0; addr_a = 5; #10;
		we_b = 1; addr_b = 8; data_b = 12; #10;
		we_b = 0; addr_b = 6; #10;
		clk = 0; #10;
	join_any
end

endmodule