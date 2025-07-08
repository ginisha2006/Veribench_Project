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
      (clear && $past(!clear)) |-> (cnt === 8'h00));

  // Property: Load operation loads value from d into counter
  assert (@(posedge clk) disable iff (!load)
      (load && $past(!load)) |-> (cnt === d));

  // Property: Up count increments counter correctly
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      (up_down && !load && !clear && $past(cnt !== 8'hFF))
         |-> (cnt === $past(cnt) + 1));

  // Property: Down count decrements counter correctly
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      (!up_down && !load && !clear && $past(cnt !== 8'h00))
         |-> (cnt === $past(cnt) - 1));

  // Property: Counter does not overflow when counting up
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      (up_down && !load && !clear && $past(cnt) === 8'hFF)
         |-> (cnt === 8'hFF));

  // Property: Counter does not underflow when counting down
  assert (@(posedge clk) disable iff (!up_down || load || clear)
      (!up_down && !load && !clear && $past(cnt) === 8'h00)
         |-> (cnt === 8'h00));

endmodule