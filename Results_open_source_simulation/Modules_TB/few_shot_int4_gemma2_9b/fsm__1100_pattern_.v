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
    clk = 0;
    rst = 1;
    bit_in = 0;
    #10 rst = 0;
    repeat (10) begin
      #5 clk = ~clk;
      bit_in = !bit_in;
    end
    #5 $finish;
  end

  initial begin
    $dumpfile("fsm_1100.vcd");
    $dumpvars(0, tb_fsm_1100);
  end
endmodule