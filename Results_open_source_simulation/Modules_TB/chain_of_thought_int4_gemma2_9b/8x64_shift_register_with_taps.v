module shift_8x64_taps_tb();

  reg clk;
  reg shift;
  reg [7:0] sr_in;
  wire [7:0] sr_tap_one, sr_tap_two, sr_tap_three, sr_out;

  shift_8x64_taps dut (clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    shift = 0;
    sr_in = 8'hFF;
    #10 shift = 1;
    #100 shift = 0;
    #10 shift = 1;
    #100 shift = 0;
    $finish;
  end

  initial begin
    $monitor("Time: %t clk=%b shift=%b sr_in=%h sr_out=%h sr_tap_one=%h sr_tap_two=%h sr_tap_three=%h", $time, clk, shift, sr_in, sr_out, sr_tap_one, sr_tap_two, sr_tap_three);
  end

endmodule