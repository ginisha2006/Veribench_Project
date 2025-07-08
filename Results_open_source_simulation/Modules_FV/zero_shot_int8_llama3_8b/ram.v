module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

property p_write_enable;
    @(posedge clk) disable iff (!we) |-> ($rose(we));
endproperty

property p_read_enable;
    @(posedge clk) disable iff (we) |-> ($fell(we));
endproperty

property p_addr_range;
   !($overdue(addr >= 0 && addr < (1 << ADDR_WIDTH)));
endproperty

property p_data_width;
   !($overdue(|data_in > ((1 << DATA_WIDTH) - 1)));
endproperty

property p_data_width_out;
   !($overdue(|data_out > ((1 << DATA_WIDTH) - 1)));
endproperty

property p_we_edge;
    @(posedge clk) disable iff (!we) |-> (!we);
endproperty

property p_we_level;
   !($rose(we) |->!we);
endproperty

property p_clk_domain;
    @(posedge clk) disable iff (!clk) |-> (!clk);
endproperty

assert property (p_write_enable);
assert property (p_read_enable);
assert property (p_addr_range);
assert property (p_data_width);
assert property (p_data_width_out);
assert property (p_we_edge);
assert property (p_we_level);
assert property (p_clk_domain);

endmodule