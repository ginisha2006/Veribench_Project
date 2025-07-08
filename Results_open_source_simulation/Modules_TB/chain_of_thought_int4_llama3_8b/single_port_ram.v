module tb_single_port_ram;

parameter WIDTH = 8;
parameter DEPTH = 64;

reg [WIDTH-1:0] data;
reg [DEPTH-1:0] addr;
reg we;
reg clk;
wire [WIDTH-1:0] q;

single_port_ram #(.WIDTH(WIDTH),.DEPTH(DEPTH)) dut (
	.data(data),
	.addr(addr),
	.we(we),
	.clk(clk),
	.q(q)
);

initial begin
	$monitor($time, "data=%b, addr=%d, we=%b, q=%b", data, addr, we, q);
	data = 0;
	addr = 0;
	we = 0;
	clk = 0;
	forever #10 clk = ~clk;
	#20;
	for (int i = 0; i < DEPTH; i++) begin
		data = i;
		addr = i;
		we = 1;
		#10;
		data = 0;
		addr = i;
		we = 0;
		#10;
	end
	data = 0;
	addr = 0;
	we = 0;
	#100;
	$stop;
end

endmodule