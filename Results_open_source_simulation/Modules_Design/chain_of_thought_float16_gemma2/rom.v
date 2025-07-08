module rom_simple (
  input [ADDR_WIDTH-1:0] addr,
  output reg [DATA_WIDTH-1:0] data_out
);

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [DATA_WIDTH-1:0] rom_data [0:255];

  initial begin
    rom_data[0] = 8'h00;
    // Add more initial values as needed
  end

  always @(*) begin
    data_out = rom_data[addr];
  end

endmodule