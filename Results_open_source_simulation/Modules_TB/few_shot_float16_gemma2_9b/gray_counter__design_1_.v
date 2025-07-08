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
    clk = 0; forever #5 clk = ~clk;
    reset = 1; #10 reset = 0;
    enable = 1; #100 enable = 0;
  end

  initial begin
    $display("Time	Reset	Enable	Gray Count");
    forever begin
      #10 $display("%0d	%b	%b	%b", $time, reset, enable, gray_count);
    end
  end
endmodule