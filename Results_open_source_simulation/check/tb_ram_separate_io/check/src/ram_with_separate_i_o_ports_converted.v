module tb_ram_separate_io #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8);

  // Inputs
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_separate_io #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) UUT (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  assert (@(posedge clk)
      (we && addr != 0)
      -> (ram_separate_io.ram[addr] == data_in));

  assert (@(posedge clk)
      (!we && addr != 0)
      -> (data_out == ram_separate_io.ram[addr]));

endmodule