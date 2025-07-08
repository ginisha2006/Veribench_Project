module tb_ram_infer();

  // Inputs
  reg clk;
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we;

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

  // Property: Check if read operation returns correct value
  property p_read_correct;
    @(posedge clk) ($stable(read_addr) &&!we) => ($rose(clk) |=> q == ram[read_addr]);
  endproperty
  assert property (p_read_correct);

  // Property: Check if write operation updates memory correctly
  property p_write_correct;
    @(posedge clk) ($stable(write_addr) && we) => ($rose(clk) |=> ram[write_addr] == data);
  endproperty
  assert property (p_write_correct);

  // Property: Check if memory does not change when we is low
  property p_no_change_when_we_low;
    @(posedge clk) (!we) => ($rose(clk) |=> ram === ram);
  endproperty
  assert property (p_no_change_when_we_low);

endmodule