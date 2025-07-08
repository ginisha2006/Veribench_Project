module tb_gray_count;
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
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1;
    #10 reset = 0;
    #10 enable = 1;
    #100 enable = 0;
    #10 $finish;
  end

  initial begin
    $dumpfile("gray_count.vcd");
    $dumpvars(0, tb_gray_count);
  end

endmodule