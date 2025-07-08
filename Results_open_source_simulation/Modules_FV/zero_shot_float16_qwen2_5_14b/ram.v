module tb_ram_simple (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] mem [255:0];

ram_simple #(.DATA_WIDTH(8), .ADDR_WIDTH(8)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk =~clk;

property p_clk_nonzero;
@(posedge clk) we |=> ##1 data_out == mem[addr];
endproperty

assert property(p_clk_nonzero);

property p_we_write;
@(posedge clk) (we && !mem[addr]) |-> ##1 mem[addr] == data_in;
endproperty

assert property(p_we_write);

property p_no_we_read;
@(posedge clk) (!we) |-> ##1 data_out == mem[addr];
endproperty

assert property(p_no_we_read);

property p_addr_range;
@(negedge clk) !(addr < 0 || addr > 255);
endproperty

assert property(p_addr_range);

endmodule