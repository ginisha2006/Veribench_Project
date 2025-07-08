module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_separate_io #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

property p_write_correctly;
    @(posedge clk) disable iff (!we) data_out == dut.ram[addr];
endproperty

property p_read_correctly;
    @(posedge clk) disable iff (we) data_out == dut.ram[addr];
endproperty

property p_addr_range;
    ($onehot0(addr) |=> $distinct0(dut.ram[addr]));
endproperty

property p_data_width;
    ($onehot0(data_in) |=> $distinct0(dut.ram[addr]));
endproperty

property p_overflow;
    ($rose(we) && addr >= (1 << ADDR_WIDTH - 1)) |=> assert false;
endproperty

property p_underflow;
    ($fell(we) && addr < 0) |=> assert false;
endproperty

assert property (p_write_correctly);
assert property (p_read_correctly);
assert property (p_addr_range);
assert property (p_data_width);
assert property (p_overflow);
assert property (p_underflow);

endmodule