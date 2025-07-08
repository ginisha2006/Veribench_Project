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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_write_operation;
    @(posedge clk)
      (we && (ram[write_addr] != data))  ===> (ram[write_addr] == data);
  endproperty
  assert property (p_write_operation);

  property p_read_operation;
    @(posedge clk)
      (ram[read_addr] == q);
  endproperty
  assert property (p_read_operation);

endmodule