module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  always #5 clk = ~clk;

  property p_count_increment;
    @(posedge clk) cnt > prev_cnt;
  endproperty

  property p_count_decrement;
    @(posedge clk) cnt < prev_cnt;
  endproperty

  property p_count_load;
    @(posedge clk) cnt == d;
  endproperty

  property p_count_clear;
    @(posedge clk) cnt == 8'h00;
  endproperty

  initial begin
    prev_cnt = 0;
  end

  assert property (p_count_increment | p_count_decrement | p_count_load | p_count_clear);



endmodule