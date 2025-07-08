module behav_counter_tb();

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
    clk = 0; forever #5 clk = ~clk; end

  initial begin
    d = 8'hFF;
    clear = 0;
    load = 0;
    up_down = 1;
    #10 clear = 1;
    #10 load = 1;
    #10 up_down = 0;
    #10 clear = 1;
    #10 load = 1;
    #10 up_down = 1;
    #100 $finish;
  end

  initial begin
    $monitor("time=%t clk=%b clear=%b load=%b up_down=%b d=%h qd=%h", $time, clk, clear, load, up_down, d, qd);
  end

endmodule