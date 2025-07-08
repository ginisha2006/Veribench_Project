module param_counter_tb;
  reg clk;
  reg rst;
  wire [7:0] count;

  param_counter #( .MAX_COUNT(255) ) dut (clk, rst, count);

  initial begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
  end

  always #5 clk = ~clk;

  initial begin
    $monitor("Time: %t clk=%b rst=%b count=%h", $time, clk, rst, count);
    #1250 $finish;
  end
endmodule