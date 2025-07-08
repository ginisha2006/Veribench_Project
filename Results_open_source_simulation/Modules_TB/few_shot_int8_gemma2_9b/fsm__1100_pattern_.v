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

  initial begin
    clk = 0; forever #5 clk = ~clk;
    rst = 1; #10 rst = 0;
  end

  initial begin
    bit_in = 0; #10;
    bit_in = 1; #10;
    bit_in = 1; #10;
    bit_in = 0; #10;
    bit_in = 1; #10;
    bit_in = 1; #10;
    bit_in = 0; #10;
    bit_in = 1; #10;
    bit_in = 1; #10;
    bit_in = 0; #10;
    $finish;
  end

endmodule