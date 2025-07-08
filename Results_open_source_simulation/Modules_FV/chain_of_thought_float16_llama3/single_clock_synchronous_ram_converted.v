module tb_ram_infer;

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, clk;
logic [7:0] q;

reg [7:0] ram[63:0];

always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we) => ram[write_addr] == data)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($fell(clk) |-> ram[read_addr] === q)); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we))); end
always @(*) begin assert (@(posedge clk)); end
assert property (~p_overflow);
assert property (~p_underflow);
assert property (~p_illegal_transition);

ram_infer uut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .clk(clk),
   .q(q)
);

endmodule