module tb_ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, read_clock, write_clock,
    output reg [7:0] q
);
    
wire clk_read = read_clock;
wire clk_write = write_clock;

reg [7:0] ram[63:0];

assert (@(posedge clk_write) disable iff (!we)
 !($onehot({we})));

assert (@(posedge clk_read) disable iff (!we)
 (q == ram[read_addr]) |-> (q == ram[write_addr]));

assert (@(posedge clk_write) disable iff (!we)
 ($isunknown(write_addr)) |=> (!$isunknown(ram[write_addr])));

assert (@(posedge clk_read)
 ($isunknown(read_addr)) |=> (!$isunknown(q)));

assert (@(posedge clk_write) disable iff (!we)
 !(write_addr < 64 && write_addr >= 0) |-> !$changed(ram[write_addr]));

assert (@(posedge clk_read)
 !(read_addr < 64 && read_addr >= 0) |-> !$changed(q));

endmodule