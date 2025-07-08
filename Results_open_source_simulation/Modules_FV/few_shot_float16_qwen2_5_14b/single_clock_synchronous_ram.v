module tb_ram_infer();

  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, clk;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_infer UUT (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
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
      ##[1:$] (write_addr == read_addr) |-> 
      $past(data, 1) == q;
  endproperty
  assert property (p_read_after_write);

  property p_no_change_on_read_only;
    @(posedge clk) disable iff (we)
      !($changed(read_addr)) |-> !($changed(q));
  endproperty
  assert property (p_no_change_on_read_only);

  property p_stable_data_between_writes;
    @(posedge clk) disable iff (!we)
      ##[2:$] (write_addr == $past(write_addr, 2)) |-> 
      $stable(data);
  endproperty
  assert property (p_stable_data_between_writes);

endmodule