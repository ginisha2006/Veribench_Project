module tb_ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, read_clock, write_clock,
    output reg [7:0] q
);
reg clk_read;
reg clk_write;

always #5 clk_read = ~clk_read;
always #10 clk_write = ~clk_write;

assert (@(posedge read_clock) disable iff (!read_clock || !write_clock)
 ($rose(read_clock)) |-> ##1 ($stable(write_addr) && $stable(we)));

assert (@(posedge write_clock) disable iff (!write_clock)
 (we && write_addr inside {[0:63]}) |-> ##1 ram[write_addr] == data);

assert (@(posedge read_clock) disable iff (!read_clock)
 (read_addr inside {[0:63]}) |-> ##1 q == ram[read_addr]);

assert (@(posedge write_clock) disable iff (!write_clock)
 (!$rose(write_clock) && !we) |-> ##1 $stable(ram[write_addr]));

assert (@(posedge read_clock) disable iff (!read_clock)
 (!$rose(read_clock)) |-> ##1 $stable(q));
endmodule