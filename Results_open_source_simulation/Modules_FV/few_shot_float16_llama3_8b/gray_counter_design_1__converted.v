module tb_gray_count();

  // Inputs
  reg clk, enable, reset;

  // Outputs
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count UUT (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
  );

  // Clock generation for properties
  integer i;
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if gray_count is updated correctly
  always @(*) begin assert (@(posedge clk) ($stable(gray_count) && (gray_count == {{~gray_count[0], gray_count}})); end

  // Property: Check if gray_count is reset correctly
  always @(*) begin assert (@(posedge reset) ($rose(reset) && $stable(gray_count) && gray_count == 8'h00)); end

  // Property: Check if gray_count increments correctly when enabled
  always @(*) begin assert (@(posedge clk) ((enable &&!reset) => $rising_edge(gray_count))); end

endmodule