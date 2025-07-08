module rom_simple #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 8
) (
  input [ADDR_WIDTH-1:0] addr,
  output reg [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] mem [0:255]; // Assuming 256 entries for demonstration

  initial begin
    // Initialize memory content here if needed
  end

  always @(*) begin
    data_out = mem[addr];
  end

endmodule