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

  // Property: Check if data_out matches the expected value from memory
  always @(*) begin assert (@(posedge clk) ($readmemh("rom_data.mem", UUT.mem)[$signed(addr)] == data_out)); end

endmodule