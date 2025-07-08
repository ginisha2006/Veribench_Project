module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // in ns

input wire logic [7:0] data;
input wire logic [5:0] read_addr, write_addr;
input wire logic we, read_clock, write_clock;
output wire logic [7:0] q;

reg [7:0] ram[63:0];

logic clk_read, clk_write;

always @(*) begin assert (@(posedge write_clock) disable iff (!we) -> we); end
always @(*) begin assert (@(posedge write_clock) disable iff (!we) -> ram[write_addr] == 8'h0); end
always @(*) begin assert (@(posedge read_clock) -> q == ram[read_addr]); end
assert property (~p_invalid_transition);
assert property (~p_overflow);
assert property (~p_underflow);

endmodule