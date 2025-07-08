module tb_ram_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8);

  // Clock
  reg clk;

  // Write enable
  reg we;

  // Address
  reg [ADDR_WIDTH-1:0] addr;

  // Data input
  reg [DATA_WIDTH-1:0] data_in;

  // Data output
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) UUT (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check write operation
  always @(*) begin assert (@(posedge clk) ((we &&!mem[$left($signed(addr))) |=> mem[$left($signed(addr))] == data_in)); end

  // Property: Check read operation
  always @(*) begin assert (@(posedge clk) (!we || mem[$left($signed(addr))] == data_out)); end

endmodule