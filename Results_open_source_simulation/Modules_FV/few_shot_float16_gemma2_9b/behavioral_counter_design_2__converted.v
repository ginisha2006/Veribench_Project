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
  always @(*) begin assert (@(posedge clk) (clear ? cnt == 8'h00 : !clear)); end

  always @(*) begin assert (@(posedge clk) (load ? cnt == d : !load)); end

  always @(*) begin assert (@(posedge clk) (up_down && !load && !clear) ? cnt == cnt + 1 : true); end

  always @(*) begin assert (@(posedge clk) (!up_down && !load && !clear) ? cnt == cnt - 1 : true); end

endmodule