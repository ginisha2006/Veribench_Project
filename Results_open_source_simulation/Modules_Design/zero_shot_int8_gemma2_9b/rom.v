module rom_simple(
  input [ADDR_WIDTH-1:0] addr,
  output [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0];

  initial begin
    $readmemh("rom_data.hex", rom);
  end

  assign data_out = rom[addr];

endmodule