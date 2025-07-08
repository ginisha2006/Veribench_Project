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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check write operation
  property p_write_operation;
    @(posedge clk) ((we &&!$past(we)) |=> ram[$signed(addr)] == data);
  endproperty
  assert property (p_write_operation);

  // Property: Check read operation
  property p_read_operation;
    @(posedge clk) (!we |=> ram[$signed(addr)] == q);
  endproperty
  assert property (p_read_operation);

  // Property: Check address update
  property p_addr_update;
    @(posedge clk) (we |=> addr == $past(addr));
  endproperty
  assert property (p_addr_update);

endmodule