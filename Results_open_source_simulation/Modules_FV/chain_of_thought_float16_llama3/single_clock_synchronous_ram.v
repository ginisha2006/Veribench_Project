module tb_ram_infer;

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, clk;
logic [7:0] q;

reg [7:0] ram[63:0];

property p_write_data;
@(posedge clk) disable iff (!we) ($rose(we) => ram[write_addr] == data);
endproperty

property p_read_data;
@(posedge clk) disable iff (!we) ($fell(clk) |-> ram[read_addr] === q);
endproperty

property p_we_edge;
@(posedge clk) disable iff (!we) ($rose(we));
endproperty

property p_clk_edge;
@(posedge clk);
endproperty

property p_overflow;
@(posedge clk) disable iff (!we) ((write_addr >= 63) || (read_addr >= 63));
endproperty

property p_underflow;
@(posedge clk) disable iff (!we) ((write_addr < 0) || (read_addr < 0));
endproperty

property p_illegal_transition;
@(posedge clk) disable iff (!we) ((write_addr!= write_addr[$past(write_addr)]) || (read_addr!= read_addr[$past(read_addr)]));
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_we_edge);
assert property (p_clk_edge);
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