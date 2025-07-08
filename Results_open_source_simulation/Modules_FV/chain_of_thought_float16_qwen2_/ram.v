module tb_ram_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

wire clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk =~clk;

property posedge_clk;
  @(posedge clk) disable iff (!we) data_out == mem[addr];
endproperty

assert property (posedge_clk);

property negedge_clk;
  @(negedge clk) disable iff (!we) mem[addr] ##1 data_out;
endproperty

assert property (negedge_clk);

property write_read;
  @(posedge clk) disable iff (!we) mem[addr] inside {[0:(1<<(ADDR_WIDTH))-1]};
endproperty

assert property (write_read);

property overflow_underflow;
  @(posedge clk) disable iff (!we) addr < (1<<ADDR_WIDTH);
endproperty

assert property (overflow_underflow);

property illegal_transition;
  @(posedge clk) disable iff (!we) !($isunknown(mem[addr]));
endproperty

assert property (illegal_transition);

endmodule