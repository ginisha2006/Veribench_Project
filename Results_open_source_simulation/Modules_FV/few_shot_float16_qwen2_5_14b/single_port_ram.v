module tb_single_port_ram();

  // Inputs
  reg [7:0] data;
  reg [5:0] addr;
  reg we, clk;

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

  // Properties
  property p_read_after_write;
    @(posedge clk) disable iff (!we)
      ##1 q == data |-> ##[1:$] (addr === addr_reg);
  endproperty
  assert property (p_read_after_write);

  property p_no_change_on_nonwrite_cycle;
    @(posedge clk) disable iff (we)
      q == $past(q);
  endproperty
  assert property (p_no_change_on_nonwrite_cycle);

  property p_data_stored_on_write;
    @(posedge clk) disable iff (!we)
      ##1 ram[addr] == data;
  endproperty
  assert property (p_data_stored_on_write);

endmodule