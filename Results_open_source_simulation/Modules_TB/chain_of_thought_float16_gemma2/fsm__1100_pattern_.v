module fsm_1100_tb;

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

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    bit_in = 0;
    #10 bit_in = 1;
    #10 bit_in = 1;
    #10 bit_in = 0;
    #10 bit_in = 1;
    #10 bit_in = 1;
    #10 bit_in = 0;
    #10 bit_in = 1;
    #10 bit_in = 1;
    #10 bit_in = 0;
    $finish;
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b bit_in=%b pattern_detected=%b", $time, clk, rst, bit_in, pattern_detected);
  end

endmodule