module gray_count_tb;

  reg clk;
  reg enable;
  reg reset;
  wire [7:0] gray_count;

  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  initial begin
    clk = 0; forever #5 clk = ~clk; end

  initial begin
    reset = 1;
    #10 reset = 0;
    enable = 1;
    #100 enable = 0;
  end

  initial begin
    $monitor("Time: %t clk=%b enable=%b reset=%b gray_count=%b", $time, clk, enable, reset, gray_count);
  end

endmodule