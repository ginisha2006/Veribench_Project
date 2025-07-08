module tb_single_port_ram;

reg [7:0] data;
reg [5:0] addr;
reg we;
wire [7:0] q;

single_port_ram dut (.data(data),.addr(addr),.we(we),.clk(clk),.q(q));

always @(*) begin assert (@(posedge clk) disable iff (!we) => ($onehot(addr))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (q == dut.ram[dut.addr])); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (addr > 6'd62)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) => (addr < 6'd0)); end

endmodule