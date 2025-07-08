module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
reg [7:0] ram[63:0];

always #5 clk = ~clk;

property p_clk_nonzero;
@(posedge clk) !($isunknown(clk)) |-> clk == 1'b1;
endproperty
assert property(p_clk_nonzero);

property p_write_enable;
@(posedge clk) (we && write_addr < 64) |=> ##1 ram[write_addr] == data;
endproperty
assert property(p_write_enable);

property p_read_enable;
@(posedge clk) (!we && read_addr < 64) |=> ##1 q == ram[read_addr];
endproperty
assert property(p_read_enable);

property p_out_of_bounds;
@(posedge clk) (write_addr >= 64 || read_addr >= 64) |-> $isunknown(q);
endproperty
assert property(p_out_of_bounds);

property p_we_conflict;
@(posedge clk) (we && write_addr == read_addr) |-> ##1 q == data;
endproperty
assert property(p_we_conflict);

property p_no_change_when_not_written;
@(posedge clk) (!we && write_addr != read_addr) |=> ##1 q == ram[read_addr];
endproperty
assert property(p_no_change_when_not_written);

endmodule