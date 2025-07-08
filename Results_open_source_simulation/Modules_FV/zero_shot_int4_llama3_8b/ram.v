module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_simple #(
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
    @(posedge clk) disable iff (!we) data_out == dut.data_in;
endproperty

property p_read_correctly;
    @(posedge clk) disable iff (we) data_out == dut.mem[addr];
endproperty

property p_addr_range;
    ($onehot0(addr) |-> $rose(we));
endproperty

property p_data_width;
    ($size(data_in) == DATA_WIDTH);
endproperty

property p_overflow;
    ($onehot0({{[DATA_WIDTH-1:0] 1'b1}} |=>!we));
endproperty

property p_underflow;
    ($onehot0({{[DATA_WIDTH-1:0] 1'b0}} |=>!we));
endproperty

assert property (p_write_correctly);
assert property (p_read_correctly);
assert property (p_addr_range);
assert property (p_data_width);
assert property (p_overflow);
assert property (p_underflow);

endmodule