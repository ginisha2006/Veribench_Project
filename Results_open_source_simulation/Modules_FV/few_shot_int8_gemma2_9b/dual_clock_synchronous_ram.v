module tb_ram_dual ();

  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we;
  reg read_clock, write_clock;

  // Output
  wire [7:0] q;

  // Instantiate the dual clock synchronous RAM
  ram_dual dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clock),
    .write_clock(write_clock),
    .q(q)
  );

  // Clock generation
  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

  // Assertions
  property p_write_operation;
    @(posedge write_clock) (ram[write_addr] == data);
  endproperty
  assert property (p_write_operation);

  property p_read_operation;
    @(posedge read_clock) (q == ram[read_addr]);
  endproperty
  assert property (p_read_operation);

endmodule