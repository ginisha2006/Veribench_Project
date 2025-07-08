module tb_ram_dual;

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, read_clock, write_clock;
logic [7:0] q;

reg [7:0] ram[63:0];

property p_write_data;
@(posedge write_clock) disable iff (!we) ($rose(we) => $distinct(data, ram[write_addr]));
endproperty

property p_read_data;
@(posedge read_clock) ($rose(read_clock) => $distinct(q, ram[read_addr]));
endproperty

property p_write_addr_range;
@(posedge write_clock) disable iff (!we) ($onehot(write_addr));
endproperty

property p_read_addr_range;
@(posedge read_clock) ($onehot(read_addr));
endproperty

property p_write_clock_domain;
@(posedge write_clock) ($stable(read_clock));
endproperty

property p_read_clock_domain;
@(posedge read_clock) ($stable(write_clock));
endproperty

property p_no_write_on_read;
@(posedge read_clock) disable iff (we) (!$we);
endproperty

property p_no_read_on_write;
@(posedge write_clock) disable iff (read_clock) (!$read_clock);
endproperty

property p_overflow_write;
@(posedge write_clock) disable iff (!we) (write_addr == 6'd62);
endproperty

property p_underflow_write;
@(posedge write_clock) disable iff (!we) (write_addr == 6'd0);
endproperty

property p_overflow_read;
@(posedge read_clock) (read_addr == 6'd62);
endproperty

property p_underflow_read;
@(posedge read_clock) (read_addr == 6'd0);
endproperty

ram_dual dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_clock),
   .we(we),
   .read_clock(read_clock),
   .write_clock(write_clock),
   .q(q)
);

assert property (p_write_data);
assert property (p_read_data);
assert property (p_write_addr_range);
assert property (p_read_addr_range);
assert property (p_write_clock_domain);
assert property (p_read_clock_domain);
assert property (p_no_write_on_read);
assert property (p_no_read_on_write);
assert property (p_overflow_write);
assert property (p_underflow_write);
assert property (p_overflow_read);
assert property (p_underflow_read);

endmodule