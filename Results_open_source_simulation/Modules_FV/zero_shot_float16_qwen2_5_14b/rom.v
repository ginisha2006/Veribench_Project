module tb_rom_simple(
    input clk,
    input [7:0] addr,
    output reg [7:0] data_out
);

wire [7:0] data_out_wire;

rom_simple #(.DATA_WIDTH(8), .ADDR_WIDTH(8)) dut (
    .addr(addr),
    .data_out(data_out_wire)
);

assign data_out = data_out_wire;

property valid_addr;
    @(posedge clk) disable iff (!reset_n)
    (addr < 256) |-> ##1 data_out == mem[addr];
endproperty

assert property(valid_addr);

property no_underflow;
    @(posedge clk) disable iff (!reset_n)
    addr >= 0;
endproperty

assert property(no_underflow);

property no_overflow;
    @(posedge clk) disable iff (!reset_n)
    addr < 256;
endproperty

assert property(no_overflow);

endmodule