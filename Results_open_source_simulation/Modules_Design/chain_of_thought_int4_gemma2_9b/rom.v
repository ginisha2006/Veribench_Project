module rom_simple #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8
)(
  input [ADDR_WIDTH-1:0] addr,
  output [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] mem [0:2**ADDR_WIDTH - 1];

  assign data_out = mem[addr];

endmodule