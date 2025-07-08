module tb_ram_dual;

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
@(posedge write_clock) disable iff (!we) |-> ram[write_addr] == 8'h00;
endproperty

property p_read_data;
@(posedge read_clock) |=> q == ram[read_addr];
endproperty

property p_no_overflow;
!(|write_addr > 63);
endproperty

property p_no_underflow;
!(|read_addr > 63);
endproperty

property p_we_active;
@(posedge write_clock) |-> we;
endproperty

property p_we_inactive;
@(posedge write_clock) |->!we;
endproperty

property p_read_clock_active;
@(posedge read_clock) |-> 1'b1;
endproperty

property p_write_clock_active;
@(posedge write_clock) |-> 1'b1;
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_no_overflow);
assert property (p_no_underflow);
assert property (p_we_active);
assert property (p_we_inactive);
assert property (p_read_clock_active);
assert property (p_write_clock_active);

endmodule