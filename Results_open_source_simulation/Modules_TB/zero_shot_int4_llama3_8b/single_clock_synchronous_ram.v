timescale 1ns / 100ps

module tb_ram_infer;

parameter CLOCK_PERIOD = 10; // in ns

reg clk;
reg [7:0] data;
reg [5:0] read_addr, write_addr;
wire [7:0] q;

ram_infer #() dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.clk(clk),
	.q(q)
);

initial begin
	#(CLOCK_PERIOD * 2); // Initialize clock
	forever #(CLOCK_PERIOD) clk = ~clk; // Generate clock
end

initial begin
	data = 8'h12;
	write_addr = 6'b000001;
	we = 1;
	@(posedge clk);
	$monitor($time, "Data written at address %b", write_addr);
	@(posedge clk);
	$display("Expected value at read addr %b is %h", write_addr, q);
	
	data = 8'h34;
	write_addr = 6'b000010;
	we = 1;
	@(posedge clk);
	$monitor($time, "Data written at address %b", write_addr);
	@(posedge clk);
	$display("Expected value at read addr %b is %h", write_addr, q);
	
	read_addr = 6'b000001;
	@(posedge clk);
	$display("Read value at address %b is %h", read_addr, q);
	
	write_addr = 6'b111110;
	we = 0;
	@(posedge clk);
	$display("Writing at out-of-range address %b", write_addr);
	
	read_addr = 6'b111110;
	@(posedge clk);
	$display("Reading from out-of-range address %b is %h", read_addr, q);
	
	#(CLOCK_PERIOD * 20); // Run for some time
	$finish;
end