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
  always @(*) begin assert (@(posedge clk) (data_out == UUT.mem[addr])); end

  // Property: Check if data_out is valid when address is within range
  always @(*) begin assert (@(posedge clk) ($isunknown(UUT.mem[addr]) || (0 <= addr && addr < (1 << ADDR_WIDTH)))); end

endmodule