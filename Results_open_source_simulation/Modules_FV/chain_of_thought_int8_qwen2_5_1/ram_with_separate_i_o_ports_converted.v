module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

assert (@(posedge clk)
    disable iff (!we)
    ($past(we)) |-> data_out == data_in after 1);

assert (@(posedge clk)
    disable iff (!we)
    !($past(we)) |-> data_out == $past(data_out));

assert (@(posedge clk)
    disable iff (!we)
    !$past(we & (addr === $past(addr))) |-> data_out == $past(data_out));

assert (@(posedge clk)
    addr < 8'd256 |-> data_out != 8'hff);

assert (@(posedge clk)
    !(we && $past(!we)) |-> data_out == $past(data_out));

endmodule