module tb_counter;
  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .result(result),
    .ena(ena)
  );

  initial begin
    clk = 0; forever #5 clk = ~clk;
    reset = 1; #10 reset = 0;
    ena = 1; #10 ena = 0;
    #100 $finish;
  end

  initial begin
    $display("Time	clk	reset	ena	result");
    forever begin
      #5 $display("%0d	%b	%b	%b	%b", $time, clk, reset, ena, result);
    end
  end
endmodule