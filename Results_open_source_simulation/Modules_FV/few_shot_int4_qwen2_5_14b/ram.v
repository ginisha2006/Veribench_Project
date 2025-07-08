module tb_ram_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)();

  // Inputs
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;

  // Output
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
  UUT (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Write operation correctness
  property p_write_operation;
    @(posedge clk) (we && mem[addr] === data_in);
  endproperty
  assert property (p_write_operation);

  // Read operation correctness
  property p_read_operation;
    @(posedge clk) (!we && data_out === mem[addr]);
  endproperty
  assert property (p_read_operation);

endmodule