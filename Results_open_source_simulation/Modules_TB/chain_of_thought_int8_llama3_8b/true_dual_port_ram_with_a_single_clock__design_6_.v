module true_dpram_sclk_tb;

reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b;
wire [7:0] q_a, q_b;
reg clk;

initial begin
	$monitor($time, "data_a = %h, data_b = %h, addr_a = %h, addr_b = %h, we_a = %b, we_b = %b, q_a = %h, q_b = %h", data_a, data_b, addr_a, addr_b, we_a, we_b, q_a, q_b);

	clk = 0; #10;
	forever begin
		#5 clk = ~clk;
	end

	data_a = 8'h12; data_b = 8'h34; addr_a = 6'b000010; addr_b = 6'b001011; we_a = 1; we_b = 0; @(posedge clk); // write to port A
	data_a = 8'h56; data_b = 8'h78; addr_a = 6'b000100; addr_b = 6'b001101; we_a = 0; we_b = 1; @(posedge clk); // write to port B
	data_a = 8'h90; data_b = 8'haa; addr_a = 6'b000110; addr_b = 6'b001110; we_a = 1; we_b = 0; @(posedge clk); // write to port A
	data_a = 8'hbb; data_b = 8'hcc; addr_a = 6'b001000; addr_b = 6'b010000; we_a = 0; we_b = 1; @(posedge clk); // read from port A
	data_a = 8'hdd; data_b = 8'hff; addr_a = 6'b001100; addr_b = 6'b010101; we_a = 1; we_b = 0; @(posedge clk); // write to port B
	data_a = 8'hee; data_b = 8'h00; addr_a = 6'b010000; addr_b = 6'b011000; we_a = 0; we_b = 1; @(posedge clk); // read from port B
	data_a = 8'hff; data_b = 8'h11; addr_a = 6'b010110; addr_b = 6'b011111; we_a = 0; we_b = 0; @(posedge clk); // read from both ports
	$stop;
end

true_dpram_sclk dut (
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

endmodule