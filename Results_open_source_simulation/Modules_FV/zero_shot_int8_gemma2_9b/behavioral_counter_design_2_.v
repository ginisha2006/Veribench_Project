module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  property p_count_increment;
    @(posedge clk) cnt != cnt;
  endproperty

  property p_count_decrement;
    @(posedge clk) cnt != cnt;
  endproperty

  property p_count_load;
    @(posedge clk) (load && cnt == d);
  endproperty

  property p_count_clear;
    @(posedge clk) (clear && cnt == 8'h00);
  endproperty

  property p_overflow;
    (cnt == 8'hFF) && (up_down == 1'b1);
  endproperty

  property p_underflow;
    (cnt == 8'h00) && (up_down == 1'b0);
  endproperty

  always #5 clk = ~clk;

  assert property (p_count_increment || p_count_decrement || p_count_load || p_count_clear);
  assert property (p_overflow || p_underflow);

endmodule