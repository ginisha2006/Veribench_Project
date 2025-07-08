module tb_ram_dual();

  // Inputs
  reg clk_w, clk_r;
  reg [7:0] data;
  reg [5:0] addr_w, addr_r;
  reg we;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_dual UUT (
   .data(data),
   .read_addr(addr_r),
   .write_addr(addr_w),
   .we(we),
   .read_clock(clk_r),
   .write_clock(clk_w),
   .q(q)
  );

  // Clock generation for properties
  initial clk_w = 0;
  always #10 clk_w = ~clk_w;
  initial clk_r = 0;
  always #10 clk_r = ~clk_r;

  // Property: Check if write operation is performed correctly
  always @(*) begin assert (@(posedge clk_w) disable iff (!we) ($stable(ram[addr_w]) && ram[addr_w] === data)); end

  // Property: Check if read operation returns correct value
  always @(*) begin assert (@(posedge clk_r) (q === ram[addr_r])); end

endmodule