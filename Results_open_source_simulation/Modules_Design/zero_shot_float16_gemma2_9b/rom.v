module rom_simple(
  input [ADDR_WIDTH-1:0] addr,
  output reg [DATA_WIDTH-1:0] data_out
);

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [DATA_WIDTH-1:0] rom_data [2**ADDR_WIDTH-1:0];

  initial begin
    rom_data[0] = 8'h00;
    rom_data[1] = 8'hFF;
    // Add more initial values as needed
  end

  always @(*) begin
    data_out = rom_data[addr];
  end

endmodule