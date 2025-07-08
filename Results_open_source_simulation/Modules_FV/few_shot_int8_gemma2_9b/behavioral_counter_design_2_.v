module tb_behav_counter();

  // Inputs
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  reg [7:0] d;

  // Output
  wire [7:0] qd;

  // Instantiate the counter
  behav_counter dut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_clear_reset;
    @(posedge clk) (clear ? cnt == 8'h00 : !clear);
  endproperty
  assert property (p_clear_reset);

  property p_load_value;
    @(posedge clk) (load ? cnt == d : !load);
  endproperty
  assert property (p_load_value);

  property p_count_up;
    @(posedge clk) (up_down ? cnt != cnt - 1 : !up_down);
  endproperty
  assert property (p_count_up);

  property p_count_down;
    @(posedge clk) (!up_down ? cnt != cnt + 1 : up_down);
  endproperty
  assert property (p_count_down);

endmodule