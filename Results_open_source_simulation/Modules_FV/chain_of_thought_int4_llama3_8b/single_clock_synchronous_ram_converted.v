module tb_ram_infer;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 6;

logic [DATA_WIDTH-1:0] data;
logic [ADDR_WIDTH-1:0] read_addr, write_addr;
logic we, clk;
logic [DATA_WIDTH-1:0] q;

ram_infer dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.clk(clk),
	.q(q)
);

always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> ($onehotb(ram[63:0][DATA_WIDTH-1:0])));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> (q == ram[read_addr]));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> ($isunknown(ram[63:0][DATA_WIDTH-1:0]) || $onehotb(ram[63:0][DATA_WIDTH-1:0])[write_addr]));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> ($isunknown(ram[63:0][DATA_WIDTH-1:0]) || $onehotb(ram[63:0][DATA_WIDTH-1:0])[read_addr]));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
	$stable(clk));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> (!$fell(we)));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$fell(we) |=> (!$rose(we)));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$stable(q));

endmodule