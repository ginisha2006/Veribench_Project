module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  property p_count_increment;
    @(posedge clk) cnt == cnt + 1 |-> up_down && !clear && !load;
  endproperty

  property p_count_decrement;
    @(posedge clk) cnt == cnt - 1 |-> !up_down && !clear && !load;
  endproperty

  property p_load_value;
    @(posedge clk) cnt == d |-> load && !clear;
  endproperty

  property p_reset_value;
    @(posedge clk) cnt == 8'h00 |-> clear;
  endproperty

  assert property (p_count_increment);
  assert property (p_count_decrement);
  assert property (p_load_value);
  assert property (p_reset_value);

  always #5 clk = ~clk;

endmodule