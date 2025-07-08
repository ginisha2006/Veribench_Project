module tb_rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)();

  // Inputs
  reg [ADDR_WIDTH-1:0] addr;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) UUT (
    .addr(addr),
    .data_out(data_out)
  );

  // Properties
  property p_valid_address;
    @(posedge $rose(addr))
    (addr < (1 << ADDR_WIDTH));
  endproperty
  assert property (p_valid_address);

  property p_data_consistency;
    @(posedge $rose(addr))
    (data_out != 'x);
  endproperty
  assert property (p_data_consistency);

endmodule