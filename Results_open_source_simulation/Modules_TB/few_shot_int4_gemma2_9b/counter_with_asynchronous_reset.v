module tb_counter;
  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;
  // Instantiate the Counter
  counter dut (
    .clk(clk),
    .reset(reset),
    .result(result),
    .ena(ena)
  );
  initial begin
    clk = 0;
    reset = 1;
    ena = 0;
    #10 reset = 0;
    #10 ena = 1;
    repeat (8) begin
      #5 clk = ~clk;
    end
    $finish;
  end
  
endmodule