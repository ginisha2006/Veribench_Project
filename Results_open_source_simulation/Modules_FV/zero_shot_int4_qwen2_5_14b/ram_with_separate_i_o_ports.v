module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
wire [ADDR_WIDTH-1:0] addr;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk = ~clk;

property read_after_write;
    @(posedge clk) disable iff (!we)
    ##1 data_out == data_in;
endproperty

assert property(read_after_write);

property write_enable;
    @(posedge clk) disable iff (!we)
    ##1 data_out != data_in;
endproperty

assert property(write_enable);

property no_read_without_write;
    @(posedge clk) disable iff (we)
    ##1 data_out != data_in;
endproperty

assert property(no_read_without_write);

property address_bounds;
    @(posedge clk) addr < 2**ADDR_WIDTH;
endproperty

assert property(address_bounds);

endmodule