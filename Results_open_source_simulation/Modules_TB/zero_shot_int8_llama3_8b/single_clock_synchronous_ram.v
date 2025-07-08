module tb_ram_infer;

reg clk;
reg [7:0] data;
reg [5:0] read_addr, write_addr;
wire [7:0] q;

initial begin
	#100; // wait for 100 time units
	clk = 0; // initialize clock
	forever #5 clk = ~clk; // toggle clock at 20 MHz

	data = 8'h12; // initial data value
	write_addr = 6'b000010; // initial write address
	we = 1; // enable write
	@(posedge clk); // wait for rising edge of clock
	$monitor($time, "Write addr: %b, Data: %h", write_addr, data);
	@(posedge clk); // wait for rising edge of clock
	we = 0; // disable write

	read_addr = 6'b001011; // read address
	@(posedge clk); // wait for rising edge of clock
	$monitor($time, "Read addr: %b, Q: %h", read_addr, q);

	#200; // wait for some time
	data = 8'h34; // new data value
	write_addr = 6'b010101; // new write address
	we = 1; // enable write
	@(posedge clk); // wait for rising edge of clock
	$monitor($time, "Write addr: %b, Data: %h", write_addr, data);
	@(posedge clk); // wait for rising edge of clock
	we = 0; // disable write

	read_addr = 6'b011110; // read address
	@(posedge clk); // wait for rising edge of clock
	$monitor($time, "Read addr: %b, Q: %h", read_addr, q);

	#500; // wait for some time
	$display("Simulation finished");
end

endmodule