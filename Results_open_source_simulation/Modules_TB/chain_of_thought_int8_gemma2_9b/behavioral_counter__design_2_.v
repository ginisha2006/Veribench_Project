module behav_counter_tb();

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (d, clk, clear, load, up_down, qd);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    d = 8'hFF;
    clear = 0;
    load = 0;
    up_down = 1;
    #100;
    clear = 1;
    #10;
    load = 1;
    #10;
    up_down = 0;
    #100;
    up_down = 1;
    #100;
    $finish;
  end

  initial begin
    $monitor("Time: %t ns, d: %b, clk: %b, clear: %b, load: %b, up_down: %b, cnt: %b", $time, d, clk, clear, load, up_down, dut.cnt);
  end

endmodule