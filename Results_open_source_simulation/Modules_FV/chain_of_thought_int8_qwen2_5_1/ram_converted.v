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

assert (@(posedge clk) disable iff (!we)
    (mem[addr] ##1 == data_in && data_out[*2] == mem[addr]));

assert (@(posedge clk) disable iff (!we)
    !(addr < 0 || addr > 255));

assert (@(posedge clk)
    !($signed(data_in) < -128 || $signed(data_in) > 127));

assert (@(posedge clk) disable iff (we)
    (data_out[*2] == data_out));

endmodule