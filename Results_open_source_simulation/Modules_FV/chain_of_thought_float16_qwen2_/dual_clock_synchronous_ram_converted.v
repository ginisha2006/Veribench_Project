module tb_ram_dual (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input read_clock,
    input write_clock,
    output reg [7:0] q
);
    
reg clk_read;
reg clk_write;

always #5 clk_read = ~clk_read;
always #10 clk_write = ~clk_write;

assert property(p_valid_address)

assert property(p_data_stability)

assert property(p_no_overlapping_writes)

assert property(p_read_after_write)

assert property(p_read_not_affected_by_unrelated_write)

endmodule