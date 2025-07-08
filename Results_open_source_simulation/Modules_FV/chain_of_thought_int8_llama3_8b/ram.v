module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] mem [(1<<ADDR_WIDTH)-1:0];

property read_after_write;
@(posedge clk) disable iff (!we) ($rose(we) |=> $readmemh(mem, addr));

property write_only_once;
@(posedge clk) disable iff (!we) (!$stable(we) |=> $past(we));

property read_stable_data;
@(posedge clk) disable iff (!we) ($rose(we) |=> $stable(data_out));

property overflow_check;
@(posedge clk) disable iff (!we) ($rose(addr) |=> $less(addr, 0) | $greater(addr, (1<<ADDR_WIDTH)-1));

property underflow_check;
@(posedge clk) disable iff (!we) ($rose(addr) |=> $greater(addr, 0) | $less(addr, (1<<ADDR_WIDTH)-1));

property we_active_at_write;
@(posedge clk) disable iff (!we) ($rose(we) |=>!we);

property we_inactive_at_read;
@(posedge clk) disable iff (!we) ($rose(!we) |=>!we);

assert property (read_after_write);
assert property (write_only_once);
assert property (read_stable_data);
assert property (overflow_check);
assert property (underflow_check);
assert property (we_active_at_write);
assert property (we_inactive_at_read);

endmodule