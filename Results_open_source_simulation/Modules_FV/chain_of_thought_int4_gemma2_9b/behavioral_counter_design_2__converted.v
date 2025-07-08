module tb_behav_counter;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  always @(*) begin assert (@(posedge clk) cnt == cnt + 1 |-> up_down && !clear && !load); end
  always @(*) begin assert (@(posedge clk) cnt == cnt - 1 |-> !up_down && !clear && !load); end
  always @(*) begin assert (@(posedge clk) cnt == d |-> load && !clear); end
  always @(*) begin assert (@(posedge clk) cnt == 8'h00 |-> clear); end

  always #5 clk = ~clk;

endmodule