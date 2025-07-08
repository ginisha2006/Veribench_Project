module tb_single_port_ram();

  // Inputs
  reg clk;
  reg [7:0] data;
  reg [5:0] addr;
  reg we;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  single_port_ram UUT (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  property p_write_operation;
    @(posedge clk)
      (we && addr != 64'h0)  => (ram[addr] == data);
  endproperty
  assert property (p_correct_write);

  property p_read_operation;
    @(posedge clk)
      (we == 0) => (q == ram[addr]);
  endproperty
  assert property (p_correct_read);


endmodule