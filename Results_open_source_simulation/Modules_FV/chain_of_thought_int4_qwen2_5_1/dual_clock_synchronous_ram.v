module tb_ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, read_clock, write_clock,
    output reg [7:0] q
);
    
wire clk_read = read_clock;
wire clk_write = write_clock;

reg [7:0] ram[63:0];

property no_concurrent_writes;
 @(posedge clk_write) disable iff (!we)
 !($onehot({we}))
endproperty

assert property(no_concurrent_writes);

property read_data_matches_written_data;
 @(posedge clk_read) disable iff (!we)
 (q == ram[read_addr]) |-> (q == ram[write_addr]);
endproperty

assert property(read_data_matches_written_data);

property write_address_valid;
 @(posedge clk_write) disable iff (!we)
 ($isunknown(write_addr)) |=> (!$isunknown(ram[write_addr]));
endproperty

assert property(write_address_valid);

property read_address_valid;
 @(posedge clk_read)
 ($isunknown(read_addr)) |=> (!$isunknown(q));
endproperty

assert property(read_address_valid);

property address_bounds_check;
 @(posedge clk_write) disable iff (!we)
 !(write_addr < 64 && write_addr >= 0) |-> !$changed(ram[write_addr]);
endproperty

assert property(address_bounds_check);

property read_address_bounds_check;
 @(posedge clk_read)
 !(read_addr < 64 && read_addr >= 0) |-> !$changed(q);
endproperty

assert property(read_address_bounds_check);

endmodule