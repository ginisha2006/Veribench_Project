module tb_ram_dual();

  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, read_clock, write_clock;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_dual UUT (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clock),
    .write_clock(write_clock),
    .q(q)
  );

  // Clock signals
  reg clk_read, clk_write;

  // Clock generation for read operations
  initial clk_read = 0;
  always #5 clk_read = ~clk_read;

  // Clock generation for write operations
  initial clk_write = 0;
  always #4 clk_write = ~clk_write; // Different period from read clock

  // Properties
  property p_data_written;
    @(posedge write_clock) disable iff (!we)
      ##1 (ram_dual.UUT.ram[write_addr] == data);
  endproperty
  assert property (p_data_written);

  property p_data_read;
    @(posedge read_clock)
      (ram_dual.UUT.ram[read_addr] == q);
  endproperty
  assert property (p_data_read);

  property p_no_race_condition;
    @(posedge read_clock, posedge write_clock)
      !($fell(write_clock) && $rose(read_clock) && (write_addr == read_addr) && we);
  endproperty
  assert property (p_no_race_condition);

endmodule