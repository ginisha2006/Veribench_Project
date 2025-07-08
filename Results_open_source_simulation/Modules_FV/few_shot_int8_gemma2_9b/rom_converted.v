module tb_rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)();

  // Inputs
  reg [ADDR_WIDTH-1:0] addr;
  
  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the ROM
  rom_simple #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) UUT (
    .addr(addr),
    .data_out(data_out)
  );

  // Assertions
  always @(*) begin assert (@(posedge clk) $range(addr, 0, 2**ADDR_WIDTH - 1)); end

  always @(*) begin assert (@(posedge clk) (data_out == mem[addr])); end


endmodule