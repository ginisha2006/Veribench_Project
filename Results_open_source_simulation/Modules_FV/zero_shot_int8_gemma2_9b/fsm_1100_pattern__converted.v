module tb_fsm_1100;

  reg clk;
  reg rst;
  reg bit_in;
  wire pattern_detected;

  fsm_1100 dut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) $past(bit_in) == 0 && bit_in == 1 && $past($past(bit_in)) == 1 && bit_in == 1); end

endmodule