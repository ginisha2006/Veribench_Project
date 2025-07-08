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
  assert (@(posedge clk) disable iff (!clear)
      !clear |-> (cnt === 8'h00));

  // Property: Load operation loads value from d into counter
  assert (@(posedge clk) disable iff (!load)
      load |-> (cnt === d));

  // Property: Up count increments counter correctly
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      up_down && !load && !clear |-> (cnt === cnt[7:0] + 1));

  // Property: Down count decrements counter correctly
  assert (@(posedge clk) disable iff (up_down || load || clear)
      !up_down && !load && !clear |-> (cnt === cnt[7:0] - 1));

  // Edge case: Overflow when counting up
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      up_down && !load && !clear && (cnt === 8'hFF) |=> (cnt === 8'h00));

  // Edge case: Underflow when counting down
  assert (@(posedge clk) disable iff (up_down || load || clear)
      !up_down && !load && !clear && (cnt === 8'h00) |=> (cnt === 8'hFF));

endmodule