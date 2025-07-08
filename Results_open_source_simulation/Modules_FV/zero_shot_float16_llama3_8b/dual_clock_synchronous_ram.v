module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // adjust this value as per your requirement

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
    @(posedge write_clock) disable iff (!we) ($rose(we) && $distinct(data, 8'h00));
endproperty

property p_read_data;
    @(posedge read_clock) ($rose(read_clock) && $distinct(q, 8'hzz));
endproperty

property p_no_underflow;
    @(posedge write_clock) disable iff (!we) ($onehot(read_addr) && $onehot(write_addr));
endproperty

property p_no_overflow;
    @(posedge write_clock) disable iff (!we) ($onehot(read_addr) && $onehot(write_addr));
endproperty

property p_write_clock_domain;
    @(posedge write_clock) ($stable(read_clock));
endproperty

property p_read_clock_domain;
    @(posedge read_clock) ($stable(write_clock));
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_no_underflow);
assert property (p_no_overflow);
assert property (p_write_clock_domain);
assert property (p_read_clock_domain);

always #CLOCK_PERIOD read_clock = ~read_clock;
always #CLOCK_PERIOD write_clock = ~write_clock;

endmodule