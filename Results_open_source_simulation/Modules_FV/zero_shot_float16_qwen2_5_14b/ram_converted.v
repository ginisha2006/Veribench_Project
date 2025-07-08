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

always @(*) begin assert (@(posedge clk) we |=> ##1 data_out == mem[addr]); end

always @(*) begin assert (@(posedge clk) (we && !mem[addr]) |-> ##1 mem[addr] == data_in); end

always @(*) begin assert (@(posedge clk) (!we) |-> ##1 data_out == mem[addr]); end

always @(*) begin assert (@(negedge clk) !(addr < 0 || addr > 255)); end

endmodule