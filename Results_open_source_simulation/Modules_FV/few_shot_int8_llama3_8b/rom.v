module tb_rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8);

  // Inputs
  reg clk;
  reg [ADDR_WIDTH-1:0] addr;

  // Output
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) UUT (
   .addr(addr),
   .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if data_out is correct
  property p_correct_data_out;
    @(posedge clk) (data_out == UUT.mem[addr]);
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if data_out is valid when address is within range
  property p_valid_addr_range;
    @(posedge clk) ($isunknown(UUT.mem[addr]) || (0 <= addr && addr < (1 << ADDR_WIDTH)));
  endproperty
  assert property (p_valid_addr_range);

endmodule