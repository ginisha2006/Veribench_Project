module tb_ram_dual ();

  // Inputs
  reg clk_r, clk_w;
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_dual UUT (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(clk_r),
    .write_clock(clk_w),
    .q(q)
  );

  // Clock generation
  initial clk_r = 0;
  always #5 clk_r = ~clk_r;
  initial clk_w = 0;
  always #10 clk_w = ~clk_w;

  // Assertions
  property p_write_operation;
    @(posedge clk_w) (ram[write_addr] == data);
  endproperty
  assert property (p_write_operation);

  property p_read_operation;
    @(posedge clk_r) (q == ram[read_addr]);
  endproperty
  assert property (p_read_operation);


endmodule