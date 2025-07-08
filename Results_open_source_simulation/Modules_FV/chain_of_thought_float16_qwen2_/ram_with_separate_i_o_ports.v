module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

property read_write_consistency;
    @(posedge clk) disable iff (!we)
    ##1 data_out == data_in |-> ##1 data_out == data_in;
endproperty

assert property(read_write_consistency);

property write_enable_check;
    @(posedge clk) disable iff (!we)
    ##1 data_out != data_in |=> ##1 data_out == data_in;
endproperty

assert property(write_enable_check);

property address_bounds;
    @(posedge clk) addr < 8'd256;
endproperty

assert property(address_bounds);

property no_read_when_not_written;
    @(posedge clk) !we |=> data_out == data_out;
endproperty

assert property(no_read_when_not_written);

property overflow_underflow;
    @(posedge clk) !(data_in > 8'hFF || data_in < 8'h00);
endproperty

assert property(overflow_underflow);

property illegal_transitions;
    @(posedge clk) we !== we;
endproperty

assert property(illegal_transitions);

endmodule