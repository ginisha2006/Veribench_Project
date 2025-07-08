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

always begin
    clk = 1'b0; #5;
    clk = 1'b1; #5;
end

property p_write_read;
    @(posedge clk) disable iff (!we)
    (mem[addr] ##1 == data_in && data_out[*2] == mem[addr]);
endproperty

assert property(p_write_read);

property p_address_range;
    @(posedge clk) disable iff (!we)
    !(addr < 0 || addr > 255);
endproperty

assert property(p_address_range);

property p_data_range;
    @(posedge clk)
    !($signed(data_in) < -128 || $signed(data_in) > 127);
endproperty

assert property(p_data_range);

property p_no_change_on_read;
    @(posedge clk) disable iff (we)
    (data_out[*2] == data_out);
endproperty

assert property(p_no_change_on_read);

endmodule