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

property p_write_data;
@(posedge write_clock) disable iff (!we);
data == ram[dut.write_addr];
endproperty

property p_read_data;
@(posedge read_clock) disable iff (!we);
q == ram[dut.read_addr];
endproperty

property p_write_conflict;
@(posedge write_clock) disable iff (we && dut.write_addr!= dut.read_addr);
$fatal("Write conflict detected");
endproperty

property p_read_conflict;
@(posedge read_clock) disable iff (we || dut.read_addr!= dut.write_addr);
$fatal("Read conflict detected");
endproperty

property p_overflow;
@(posedge write_clock) disable iff (dut.write_addr >= 63);
$fatal("Write address overflow");
endproperty

property p_underflow;
@(posedge write_clock) disable iff (dut.write_addr < 0);
$fatal("Write address underflow");
endproperty

property p_read_overflow;
@(posedge read_clock) disable iff (dut.read_addr >= 63);
$fatal("Read address overflow");
endproperty

property p_read_underflow;
@(posedge read_clock) disable iff (dut.read_addr < 0);
$fatal("Read address underflow");
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_write_conflict);
assert property (p_read_conflict);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_read_overflow);
assert property (p_read_underflow);

endmodule