module param_counter_tb;
  reg clk;
  reg rst;
  wire [7:0] count;

  param_counter dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    #260 rst = 1;
  end

  initial begin
    $monitor("Time: %t ns, clk: %b, rst: %b, count: %h", $time, clk, rst, count);
  end
endmodule