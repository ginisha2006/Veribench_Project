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

property p_read_correct;
    @(posedge read_clock) disable iff (!we);
    q == dut.ram[read_addr];
endproperty

property p_write_correct;
    @(posedge write_clock) disable iff (!we);
    dut.ram[write_addr] == data;
endproperty

property p_overflow_underflow;
    ($onehot(read_addr) && $onehot(write_addr)) |-> (read_addr!= write_addr);
endproperty

property p_edge_cases;
    @(posedge read_clock) disable iff (!we);
   !we |=> (q === 8'h0);
    @(posedge write_clock) disable iff (!we);
   !we |=> (dut.ram[write_addr] === 8'h0);
endproperty

property p_timing_constraints;
    @(posedge read_clock) disable iff (!we);
    read_clock ##1 write_clock |=> (read_addr == write_addr);
endproperty

assert property (p_read_correct);
assert property (p_write_correct);
assert property (p_overflow_underflow);
assert property (p_edge_cases);
assert property (p_timing_constraints);

endmodule