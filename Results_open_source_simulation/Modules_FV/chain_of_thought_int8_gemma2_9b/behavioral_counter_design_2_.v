module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  property p_count_increment;
    @(posedge clk) cnt == cnt + 1;
  endproperty

  property p_count_decrement;
    @(posedge clk) cnt == cnt - 1;
  endproperty

  property p_clear;
    !clear  => cnt == 8'h00;
  endproperty

  property p_load;
    load  => cnt == d;
  endproperty

  property p_overflow;
    cnt == 255 && up_down;
  endproperty

  property p_underflow;
    cnt == 0 && !up_down;
  endproperty

  assert property (p_count_increment || p_count_decrement);
  assert property (p_clear);
  assert property (p_load);
  assert property (p_overflow || !p_underflow);


  always #5 clk = ~clk;

endmodule