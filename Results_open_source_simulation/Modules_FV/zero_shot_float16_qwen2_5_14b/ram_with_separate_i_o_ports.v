module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

property p_clk_nonzero;
  @(posedge clk) disable iff (!clk) we !== 0;
endproperty

assert property(p_clk_nonzero);

property p_read_write;
  @(posedge clk) disable iff (!clk) !we |-> data_out == data_in;
endproperty

assert property(p_read_write);

property p_write_correctness;
  @(posedge clk) disable iff (!clk) we ##1 $stable(addr) |-> data_out == data_in;
endproperty

assert property(p_write_correctness);

property p_address_bounds;
  @(posedge clk) disable iff (!clk) addr < 8'b1111_1111;
endproperty

assert property(p_address_bounds);

property p_data_bounds;
  @(posedge clk) disable iff (!clk) data_in < 8'd256;
endproperty

assert property(p_data_bounds);

ram_separate_io #(.DATA_WIDTH(8), .ADDR_WIDTH(8)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

endmodule