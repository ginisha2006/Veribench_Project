module tb_ram_dual();

  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, read_clk, write_clk;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_dual UUT (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clk),
    .write_clock(write_clk),
    .q(q)
  );

  // Clock signals
  reg clk_read, clk_write;

  // Clock generation for read operations
  initial clk_read = 0;
  always #5 clk_read = ~clk_read;

  // Clock generation for write operations
  initial clk_write = 0;
  always #7 clk_write = ~clk_write; // Different period from read clock

  // Properties
  always @(*) begin assert (@(posedge write_clk) $rose(we) |-> ##1 ram[write_addr] == data); end

  always @(*) begin assert (@(posedge read_clk) $past(we) && (read_addr == $past(write_addr)) |-> q == $past(ram[write_addr])); end

endmodule