module tb_behav_counter();

  // Inputs
  reg [7:0] d;
  reg clk;
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

  // Property: Clear operation sets counter to zero
  property p_clear_to_zero;
    @(posedge clk) disable iff (!clear)
      !clear |-> (cnt === 8'h00);
  endproperty
  assert property (p_clear_to_zero);

  // Property: Load operation loads value from d into counter
  property p_load_value;
    @(posedge clk) disable iff (!load)
      load |-> (cnt === d);
  endproperty
  assert property (p_load_value);

  // Property: Up count increments counter correctly
  property p_up_count;
    @(posedge clk) disable iff (!up_down || load || clear)
      up_down && !load && !clear |-> (cnt === cnt[7:0] + 1);
  endproperty
  assert property (p_up_count);

  // Property: Down count decrements counter correctly
  property p_down_count;
    @(posedge clk) disable iff (up_down || load || clear)
      !up_down && !load && !clear |-> (cnt === cnt[7:0] - 1);
  endproperty
  assert property (p_down_count);

  // Edge case: Overflow when counting up
  property p_overflow_up;
    @(posedge clk) disable iff (!up_down || load || clear)
      up_down && !load && !clear && (cnt === 8'hFF) |=> (cnt === 8'h00);
  endproperty
  assert property (p_overflow_up);

  // Edge case: Underflow when counting down
  property p_underflow_down;
    @(posedge clk) disable iff (up_down || load || clear)
      !up_down && !load && !clear && (cnt === 8'h00) |=> (cnt === 8'hFF);
  endproperty
  assert property (p_underflow_down);

endmodule