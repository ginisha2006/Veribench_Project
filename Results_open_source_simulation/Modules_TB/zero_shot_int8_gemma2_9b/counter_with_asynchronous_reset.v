module counter_tb;

  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1;
    #10 reset = 0;
    ena = 1;
    #100 ena = 0;
    #100 reset = 1;
    #10 reset = 0;
    ena = 1;
  end

  initial begin
    $monitor("Time: %0t clk=%b reset=%b ena=%b result=%h", $time, clk, reset, ena, result);
  end

endmodule