module tb_ram_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)();

  // Inputs
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;

  // Output
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
  UUT (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Data out should reflect written value when address matches
  property p_data_out_matches_write;
    @(posedge clk) disable iff (!we)
      ##1 data_out == mem[addr];
  endproperty
  assert property (p_data_out_matches_write);

  // Property: Data out should not change when write enable is low
  property p_no_change_when_we_low;
    @(posedge clk) disable iff (we)
      data_out == mem[addr];
  endproperty
  assert property (p_no_change_when_we_low);

  // Property: Write operation updates memory correctly
  property p_memory_update;
    @(posedge clk) disable iff (!we)
      mem[addr] == data_in;
  endproperty
  assert property (p_memory_update);

endmodule