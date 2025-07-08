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

  // Property: Data out should reflect written data when address matches
  assert (@(posedge clk) disable iff (!we)
      (mem[addr] == data_in) |-> (data_out == mem[addr]));

  // Property: Data out should remain unchanged when write enable is low
  assert (@(posedge clk) disable iff (we)
      !we |=> data_out == mem[addr]);

  // Property: Address range check
  always @(*) begin assert (@(posedge clk) addr < (1 << ADDR_WIDTH)); end

endmodule