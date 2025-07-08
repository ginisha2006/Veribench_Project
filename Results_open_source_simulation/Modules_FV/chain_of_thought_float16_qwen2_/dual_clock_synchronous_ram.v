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

property p_valid_address;
    @(posedge read_clock) disable iff (!we)
        read_addr inside {[0:63]} |-> ##1 q == ram[read_addr];
    @(posedge write_clock) disable iff (!we)
        write_addr inside {[0:63]};
endproperty
assert property(p_valid_address)

property p_data_stability;
    @(posedge write_clock) disable iff (!we)
        data !== ? |=> ##1 ram[write_addr] === data;
endproperty
assert property(p_data_stability)

property p_no_overlapping_writes;
    @(posedge write_clock) disable iff (!we)
        write_addr !== ? |=> ##1 !($past(we));
endproperty
assert property(p_no_overlapping_writes)

property p_read_after_write;
    @(posedge write_clock) disable iff (!we)
        we &&##1 read_clock && (read_addr == write_addr) |-> 
            ##1 q === data;
endproperty
assert property(p_read_after_write)

property p_read_not_affected_by_unrelated_write;
    @(posedge write_clock) disable iff (!we)
        write_addr !== read_addr |=> ##1 q !== data;
endproperty
assert property(p_read_not_affected_by_unrelated_write)

endmodule