module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) disable iff (!clk) we !== 0); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) !we |-> data_out == data_in); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) we ##1 $stable(addr) |-> data_out == data_in); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) addr < 8'b1111_1111); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) data_in < 8'd256); end

ram_separate_io #(.DATA_WIDTH(8), .ADDR_WIDTH(8)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

endmodule