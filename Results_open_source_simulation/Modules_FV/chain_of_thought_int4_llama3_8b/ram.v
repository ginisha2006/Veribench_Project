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
    @(posedge clk) disable iff (!we) data_out == mem[addr];
endproperty

property p_read_correctly;
    @(posedge clk) disable iff (we) data_out == mem[addr];
endproperty

property p_addr_range;
    ($onehot(addr) && addr < (1 << ADDR_WIDTH));
endproperty

property p_data_width;
    ($size(data_in) == DATA_WIDTH);
endproperty

property p_we_edge;
    (posedge clk |=>!we);
endproperty

property p_we_deglitch;
    (posedge clk |=> ##1!we);
endproperty

property p_addr_edge;
    (posedge clk |=> $stable(addr));
endproperty

property p_addr_deglitch;
    (posedge clk |=> ##1 $stable(addr));
endproperty

assert property (p_write_correctly);
assert property (p_read_correctly);
assert property (p_addr_range);
assert property (p_data_width);
assert property (p_we_edge);
assert property (p_we_deglitch);
assert property (p_addr_edge);
assert property (p_addr_deglitch);

endmodule