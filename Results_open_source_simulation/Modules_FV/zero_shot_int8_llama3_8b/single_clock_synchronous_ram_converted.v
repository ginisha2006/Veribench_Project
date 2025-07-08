module tb_ram_infer;

import uvm_pkg::*;

reg [7:0] data;

reg [5:0] read_addr, write_addr;

bit we;

reg clk = 1'b0;

reg [7:0] q;

ram_infer dut (.data(data),.read_addr(read_addr),.write_addr(write_addr),.we(we),.clk(clk),.q(q));

always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(ram[write_addr]) && ram[write_addr] == data)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (ram[read_addr] == q)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((write_addr >= 63) | (write_addr < 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (~((write_addr >= 63) & (write_addr < 0)))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((read_addr >= 63) | (read_addr < 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (~((read_addr >= 63) & (read_addr < 0)))); end

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