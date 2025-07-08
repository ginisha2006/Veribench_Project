module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // adjust this value according to your design's clock period

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, read_clock, write_clock;
logic [7:0] q;

ram_dual dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.read_clock(read_clock),
	.write_clock(write_clock),
	.q(q)
);

always @(*) begin assert (@(posedge write_clock) disable iff (!we); end
data == ram[dut.write_addr]);
always @(*) begin assert (@(posedge read_clock) disable iff (!we); end
q == ram[dut.read_addr]);
always @(*) begin assert (@(posedge write_clock) disable iff (we && dut.write_addr!= dut.read_addr); end
$fatal("Write conflict detected"));
always @(*) begin assert (@(posedge read_clock) disable iff (we || dut.read_addr!= dut.write_addr); end
$fatal("Read conflict detected"));
always @(*) begin assert (@(posedge write_clock) disable iff (dut.write_addr >= 63); end
$fatal("Write address overflow"));
always @(*) begin assert (@(posedge write_clock) disable iff (dut.write_addr < 0); end
$fatal("Write address underflow"));
always @(*) begin assert (@(posedge read_clock) disable iff (dut.read_addr >= 63); end
$fatal("Read address overflow"));
always @(*) begin assert (@(posedge read_clock) disable iff (dut.read_addr < 0); end
$fatal("Read address underflow"));

endmodule