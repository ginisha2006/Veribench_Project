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
  property p_write_operation;
    @(posedge clk) ((we &&!mem[$left($signed(addr))) |=> mem[$left($signed(addr))] == data_in);
  endproperty
  assert property (p_write_operation);

  // Property: Check read operation
  property p_read_operation;
    @(posedge clk) (!we || mem[$left($signed(addr))] == data_out);
  endproperty
  assert property (p_read_operation);

endmodule