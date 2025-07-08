module tb_behav_counter();

  // Inputs
  reg clk;
  reg [7:0] d;
  reg clear;
  reg load;
  reg up_down;

  // Output
  wire [7:0] qd;

  // Instantiate the DUT
  behav_counter UUT (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Clear resets counter to zero
  assert (@(posedge clk) disable iff (!reset)
      !clear |-> (cnt === 8'h00));

  // Property: Load sets counter value to d
  assert (@(posedge clk) disable iff (!reset)
      load && !clear |-> (cnt === d));

  // Property: Up count increments counter correctly
  assert (@(posedge clk) disable iff (!reset)
      up_down && !clear && !load |-> (cnt === cnt[7:0] + 1));

  // Property: Down count decrements counter correctly
  assert (@(posedge clk) disable iff (!reset)
      !up_down && !clear && !load |-> (cnt === cnt[7:0] - 1));

endmodule