module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

property read_write_correctness;
    @(posedge clk)
    disable iff (!we)
    ($past(we)) |-> data_out == data_in after 1;
endproperty

assert property(read_write_correctness);

property write_stability;
    @(posedge clk)
    disable iff (!we)
    !($past(we)) |-> data_out == $past(data_out);
endproperty

assert property(write_stability);

property no_read_when_not_written;
    @(posedge clk)
    disable iff (!we)
    !$past(we & (addr === $past(addr))) |-> data_out == $past(data_out);
endproperty

assert property(no_read_when_not_written);

property overflow_underflow;
    @(posedge clk)
    addr < 8'd256 |-> data_out != 8'hff;
endproperty

assert property(overflow_underflow);

property illegal_transitions;
    @(posedge clk)
    !(we && $past(!we)) |-> data_out == $past(data_out);
endproperty

assert property(illegal_transitions);

endmodule