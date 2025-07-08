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
  always @(*) begin assert (@(posedge clk) ((we &&!$past(we)) |=> ram[$signed(addr)] == data)); end

  // Property: Check read operation
  always @(*) begin assert (@(posedge clk) (!we |=> ram[$signed(addr)] == q)); end

  // Property: Check address update
  always @(*) begin assert (@(posedge clk) (we |=> addr == $past(addr))); end

endmodule