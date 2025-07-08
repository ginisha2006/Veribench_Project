module tb_ram_infer;

import uvm_pkg::*;

reg [7:0] data;

reg [5:0] read_addr, write_addr;

bit we;

reg clk = 1'b0;

reg [7:0] q;

ram_infer dut (.data(data),.read_addr(read_addr),.write_addr(write_addr),.we(we),.clk(clk),.q(q));

property p_write_data;
	@(posedge clk) disable iff (!we) ($rose(ram[write_addr]) && ram[write_addr] == data);
endproperty

property p_read_data;
	@(posedge clk) disable iff (!we) (ram[read_addr] == q);
endproperty

property p_overflow_write;
	@(posedge clk) disable iff (!we) ((write_addr >= 63) | (write_addr < 0));
endproperty

property p_underflow_write;
	@(posedge clk) disable iff (!we) (~((write_addr >= 63) & (write_addr < 0)));
endproperty

property p_overflow_read;
	@(posedge clk) disable iff (!we) ((read_addr >= 63) | (read_addr < 0));
endproperty

property p_underflow_read;
	@(posedge clk) disable iff (!we) (~((read_addr >= 63) & (read_addr < 0)));
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_overflow_write);
assert property (p_underflow_write);
assert property (p_overflow_read);
assert property (p_underflow_read);

always @(posedge clk) begin
	#10 clk =~ clk;
end

initial begin
	$fsdbDumpfile("dump.fsdb");
	$fsdbDumpvars();
	fork
	#1000000 $finish;
	join
end

endmodule