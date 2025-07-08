module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] ram[255:0];

always begin
    clk = ~clk;
    #(5ns);
end

property read_after_write;
    @(posedge clk) disable iff (!we)
    ##1 data_out == ram[addr];
endproperty

assert property(read_after_write);

property write_enable;
    @(posedge clk) disable iff (!we)
    ##1 ram[addr] == data_in;
endproperty

assert property(write_enable);

property no_read_when_not_writing;
    @(posedge clk) disable iff (we)
    ##1 data_out !== ram[addr];
endproperty

assert property(no_read_when_not_writing);

property address_bounds;
    @(posedge clk) addr inside {[0:255]};
endproperty

assert property(address_bounds);

endmodule