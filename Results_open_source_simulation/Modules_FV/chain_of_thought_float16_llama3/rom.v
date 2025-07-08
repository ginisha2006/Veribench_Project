module tb_rom_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input [ADDR_WIDTH-1:0] addr;
output [DATA_WIDTH-1:0] data_out;

rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .addr(addr),
   .data_out(data_out)
);

property p_read_valid_addr;
    @(posedge clk) disable iff (!clk) ((addr >= 0) && (addr < (1 << ADDR_WIDTH));
assert property (p_read_valid_addr);

property p_read_valid_data;
    @(posedge clk) disable iff (!clk) ($onehot(data_out));
assert property (p_read_valid_data);

property p_read_invalid_addr;
    @(posedge clk) disable iff (!clk) ((addr >= (1 << ADDR_WIDTH) || addr < 0);
assert property (p_read_invalid_addr);

property p_write_invalid_addr;
    @(negedge clk) disable iff (!clk) ((addr >= (1 << ADDR_WIDTH) || addr < 0);
assert property (p_write_invalid_addr);

property p_clock_transition;
    @(posedge clk) disable iff (!clk) (~clk);
assert property (p_clock_transition);

clock clk;
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

endmodule