module rom_simple(
  input [ADDR_WIDTH-1:0] addr,
  output [DATA_WIDTH-1:0] data_out
);

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

  assign data_out = mem[addr];

endmodule