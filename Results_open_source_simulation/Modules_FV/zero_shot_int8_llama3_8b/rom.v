module tb_rom_simple;

// Parameters
localparam DATA_WIDTH = 8;
localparam ADDR_WIDTH = 8;

// Signals
reg clk;
reg [ADDR_WIDTH-1:0] addr;
wire [DATA_WIDTH-1:0] data_out;

// DUT instantiation
rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .addr(addr),
   .data_out(data_out)
);

// Clock generation
always #10 clk = ~clk; // 10ns period

// Properties
property p_read_correctness;
@(posedge clk) disable iff (!clk) ($rose(addr) |=> $distinct(data_out, {DATA_WIDTH{1'b0}));
endproperty

property p_write_overflow;
@(negedge clk) disable iff (!clk) ((addr >= (1 << ADDR_WIDTH) - 1) |=> $fatal("ROM write overflow"));
endproperty

property p_write_underflow;
@(negedge clk) disable iff (!clk) ((addr < 0) |=> $fatal("ROM write underflow"));
endproperty

assert property (p_read_correctness);
assert property (p_write_overflow);
assert property (p_write_underflow);

endmodule