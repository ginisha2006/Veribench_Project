module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // in ns

input wire logic [7:0] data;
input wire logic [5:0] read_addr, write_addr;
input wire logic we, read_clock, write_clock;
output wire logic [7:0] q;

reg [7:0] ram[63:0];

logic clk_read, clk_write;

property p_we_at_posedge_write_clock;
@(posedge write_clock) disable iff (!we) -> we;
endproperty

property p_data_written_at_posedge_write_clock;
@(posedge write_clock) disable iff (!we) -> ram[write_addr] == 8'h0;
endproperty

property p_q_updated_at_posedge_read_clock;
@(posedge read_clock) -> q == ram[read_addr];
endproperty

property p_invalid_transition;
(read_clock &&!we) | (write_clock &&!we);
endproperty

property p_overflow;
(write_addr > 63 || read_addr > 63);
endproperty

property p_underflow;
(write_addr < 0 || read_addr < 0);
endproperty

assert property (p_we_at_posedge_write_clock);
assert property (p_data_written_at_posedge_write_clock);
assert property (p_q_updated_at_posedge_read_clock);
assert property (~p_invalid_transition);
assert property (~p_overflow);
assert property (~p_underflow);

endmodule