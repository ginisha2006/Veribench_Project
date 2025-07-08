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
  assert (@(posedge $rose(addr))
    (addr < (1 << ADDR_WIDTH)));

  assert (@(posedge $rose(addr))
    (data_out != 'x));

endmodule