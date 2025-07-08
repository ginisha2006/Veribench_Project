module tb_ram_separate_io #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8);

  // Clock
  reg clk;
  initial clk = 0;
  always #5 clk = ~clk;

  // Write Enable
  reg we;

  // Address
  reg [ADDR_WIDTH-1:0] addr;

  // Data Input
  reg [DATA_WIDTH-1:0] data_in;

  // Data Output
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_separate_io #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) UUT (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
  );

  // Property: Check write operation
  always @(*) begin assert (@(posedge clk) (we && addr!= 0) implies (UUT.data_out == data_in)); end

  // Property: Check read operation
  always @(*) begin assert (@(posedge clk) (!we || addr == 0) implies (UUT.data_out == ram[addr])); end

  // Property: Check reset operation
  always @(*) begin assert (@(posedge clk) (we && addr == 0) implies (UUT.data_out == 0)); end

endmodule