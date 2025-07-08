timescale 1ns / 100ps;

module tb_ram_infer;

parameter CLOCK_PERIOD = 10; // in ns

reg clk;
reg [7:0] data;
reg [5:0] read_addr, write_addr;
wire [7:0] q;

ram_infer dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.clk(clk),
	.q(q)
);

initial begin
	#-CLOCK_PERIOD * 5; // delay for clock stabilization
	clk = 0;
	forever #CLOCK_PERIOD clk = ~clk;
end

initial begin
	data = 8'h12;
	write_addr = 6'b000001;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=%b, write_addr=%b, we=%b", data, write_addr, we);
	@(posedge clk);
	data = 8'h34;
	write_addr = 6'b000010;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=%b, write_addr=%b, we=%b", data, write_addr, we);
	@(posedge clk);
	read_addr = 6'b000011;
	@(posedge clk);
	$display("q = %b", q);
	
	data = 8'h56;
	write_addr = 6'b000100;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=%b, write_addr=%b, we=%b", data, write_addr, we);
	@(posedge clk);
	read_addr = 6'b000101;
	@(posedge clk);
	$display("q = %b", q);
	
	data = 8'h78;
	write_addr = 6'b111110;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=%b, write_addr=%b, we=%b", data, write_addr, we);
	@(posedge clk);
	read_addr = 6'b111111;
	@(posedge clk);
	$display("q = %b", q);
	
	#500; // wait for some time before stopping simulation
	$stop;
end