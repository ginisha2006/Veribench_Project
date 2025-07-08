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
  always #10 clk = ~clk;

  // Property: Check if read operation returns correct value
  property p_read_correct;
    @(posedge clk) (q == ram[read_addr]);
  endproperty
  assert property (p_read_correct);

  // Property: Check if write operation updates the memory correctly
  property p_write_correct;
    @(posedge clk) (we && (ram[write_addr]!= data)) |-> (ram[write_addr] == data);
  endproperty
  assert property (p_write_correct);

  // Property: Check if read operation returns default value when address is out of range
  property p_read_default_value;
    @(posedge clk) (!$rose(read_addr) ||!$fell(read_addr)) |=> (q == 8'h00);
  endproperty
  assert property (p_read_default_value);

endmodule