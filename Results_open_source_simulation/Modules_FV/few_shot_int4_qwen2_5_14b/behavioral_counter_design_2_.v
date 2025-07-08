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
  property p_clear_reset;
    @(posedge clk) disable iff (!reset)
      !clear |-> (cnt === 8'h00);
  endproperty
  assert property (p_clear_reset);

  // Property: Load sets counter value to d
  property p_load_set;
    @(posedge clk) disable iff (!reset)
      load && !clear |-> (cnt === d);
  endproperty
  assert property (p_load_set);

  // Property: Up count increments counter correctly
  property p_up_count;
    @(posedge clk) disable iff (!reset)
      up_down && !clear && !load |-> (cnt === cnt[7:0] + 1);
  endproperty
  assert property (p_up_count);

  // Property: Down count decrements counter correctly
  property p_down_count;
    @(posedge clk) disable iff (!reset)
      !up_down && !clear && !load |-> (cnt === cnt[7:0] - 1);
  endproperty
  assert property (p_down_count);

endmodule