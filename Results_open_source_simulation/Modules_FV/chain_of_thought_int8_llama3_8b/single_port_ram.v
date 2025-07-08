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

property p_write_data;
@(posedge clk) disable iff (!we) ($rose(we) |=> $distinct(data, 8'h00));
endproperty

property p_read_data;
@(posedge clk) disable iff (!we) ($rose(we) |=> $distinct(q, 8'hzzz));
endproperty

property p_addr_range;
@(posedge clk) disable iff (!we) ($rose(we) |=> $distinct(addr, 6'h000000));

property p_clk_domain;
@(posedge clk) disable iff (!we) ($rose(we) |=> #10 $stable(clk));

property p_we_edge;
@(posedge clk) disable iff (!we) ($rose(we) |=>!#1 $fell(we));

property p_addr_update;
@(posedge clk) disable iff (!we) ($rose(we) |=> $distinct(addr_reg, 6'hzzz));

assert property (p_write_data);
assert property (p_read_data);
assert property (p_addr_range);
assert property (p_clk_domain);
assert property (p_we_edge);
assert property (p_addr_update);

endmodule