module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  assert property (p_count_increment || p_count_decrement || p_count_load || p_count_clear);
  always @(*) begin assert (!((cnt == 8'hFF) && up_down) && !((cnt == 8'h00) && !up_down)); end
  always @(*) begin assert (!((cnt == 8'h00) && up_down) && !((cnt == 8'hFF) && !up_down)); end

  always #5 clk = ~clk;

endmodule