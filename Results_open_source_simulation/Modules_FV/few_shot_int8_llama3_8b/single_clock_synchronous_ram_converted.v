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
  always @(*) begin assert (@(posedge clk) ($stable(read_addr) &&!we) => ($rose(clk) |=> q == ram[read_addr])); end

  // Property: Check if write operation updates memory correctly
  always @(*) begin assert (@(posedge clk) ($stable(write_addr) && we) => ($rose(clk) |=> ram[write_addr] == data)); end

  // Property: Check if memory does not change when we is low
  always @(*) begin assert (@(posedge clk) (!we) => ($rose(clk) |=> ram === ram)); end

endmodule