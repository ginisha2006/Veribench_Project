module behav_counter_tb;

  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  wire [7:0] qd;

  behav_counter dut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    d = 8'hFF;
    clear = 1'b1;
    load = 1'b0;
    up_down = 1'b1;
    #10 clear = 1'b0;
    #10 load = 1'b1;
    #10 up_down = 1'b0;
    #10 clear = 1'b1;
    #10 load = 1'b0;
    #10 up_down = 1'b1;
  end

  initial begin
    $monitor("Time: %t clk=%b clear=%b load=%b up_down=%b cnt=%b", $time, clk, clear, load, up_down, qd);
  end

endmodule