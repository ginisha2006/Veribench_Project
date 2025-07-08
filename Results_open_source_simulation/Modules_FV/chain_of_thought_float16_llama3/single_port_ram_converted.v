module tb_single_port_ram;

logic [7:0] data;
logic [5:0] addr;
logic we, clk;
logic [7:0] q;

single_port_ram dut (
   .data(data),
   .addr(addr),
   .we(we),
   .clk(clk),
   .q(q)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we) => $distinct(data, 8'h00))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($fell(clk) => $distinct(q, 8'hzz))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((addr < 6'd0) | (addr > 6'd63))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($stable(clk))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($fell(we))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (!$stable(we))); end

endmodule