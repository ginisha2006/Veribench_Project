module tb_behav_counter();

  // Inputs
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  reg [7:0] d;

  // Output
  wire [7:0] cnt;

  // Instantiate the DUT
  behav_counter UUT (
   .d(d),
   .clk(clk),
   .clear(clear),
   .load(load),
   .up_down(up_down),
   .qd(cnt)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if counter resets to zero when clear is high
  always @(*) begin assert (@(posedge clk) ($rose(clear) |=> cnt == 8'h0)); end

  // Property: Check if counter loads with new value when load is high
  always @(*) begin assert (@(posedge clk) ($rose(load) |=> cnt == d)); end

  // Property: Check if counter increments when up_down is high
  always @(*) begin assert (@(posedge clk) ($rose(up_down) |=> cnt == cnt + 1)); end

  // Property: Check if counter decrements when up_down is low
  always @(*) begin assert (@(posedge clk) (!$rose(up_down) |=> cnt == cnt - 1)); end

endmodule