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

  // Clock generation for properties
  initial read_clock = 0;
  always #5 read_clock = ~read_clock;

  initial write_clock = 0;
  always #4 write_clock = ~write_clock; 

  // Properties
  property p_read_data;
    @(posedge read_clock)
    (q === ram_dual::UUT.ram[read_addr]);
  endproperty
  assert property (p_read_data);

  property p_write_data;
    @(posedge write_clock)
    ($past(we) && $rose(write_clock))
        |-> ram_dual::UUT.ram[write_addr] === data;
  endproperty
  assert property (p_write_data);

endmodule