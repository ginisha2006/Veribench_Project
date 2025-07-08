module tb_param_counter;
  // Parameter
  parameter MAX_COUNT = 255; // Default maximum count value
  // Inputs
  reg clk;
  reg rst;
  // Output
  wire [$clog2(MAX_COUNT+1)-1:0] count;
  // Instantiate the Parameterized Counter
  param_counter #( .MAX_COUNT(MAX_COUNT) ) uut (
      .clk(clk),
      .rst(rst),
      .count(count)
  );
  initial begin
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Reset pulse
    rst = 1;
    #10 rst = 0;
    // Monitor the counter value
    $monitor("Time	Count", $time, count);
    // Wait until the simulation ends
    # (MAX_COUNT * 10);
    $finish;
  end
endmodule