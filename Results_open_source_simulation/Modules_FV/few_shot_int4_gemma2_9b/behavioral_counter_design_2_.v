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

  // Properties
  property p_clear;
    @(posedge clk) (clear == 1'b1) -> cnt == 8'h00;
  endproperty
  assert property (p_clear);

  property p_load;
    @(posedge clk) (load == 1'b1) -> cnt == d;
  endproperty
  assert property (p_load);

  property p_up_down;
    @(posedge clk) (up_down == 1'b1) -> cnt == cnt + 1;
  endproperty
  assert property (p_up_down);

  property p_down;
    @(posedge clk) (up_down == 1'b0) -> cnt == cnt - 1;
  endproperty
  assert property (p_down);


endmodule