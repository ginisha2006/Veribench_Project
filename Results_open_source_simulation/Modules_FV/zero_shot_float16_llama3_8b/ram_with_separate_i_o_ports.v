module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

property p_write_correctness;
    @(posedge clk) disable iff (!we) ((dut.data_out == dut.ram[dut.addr]) && (dut.ram[dut.addr] == data_in));
endproperty

property p_read_correctness;
    @(posedge clk) disable iff (we) (dut.data_out == dut.ram[dut.addr]);
endproperty

property p_overflow_underflow;
    @(posedge clk) ($fell(dut.addr) |=> $rose(dut.addr) |=> (dut.addr < (1 << ADDR_WIDTH - 1) || dut.addr >= (1 << ADDR_WIDTH)));
endproperty

property p_we_edge;
    @(posedge clk) disable iff (!we)!we;
endproperty

property p_we_level;
    @(posedge clk) disable iff (we) we;
endproperty

assert property (p_write_correctness);
assert property (p_read_correctness);
assert property (p_overflow_underflow);
assert property (p_we_edge);
assert property (p_we_level);

endmodule