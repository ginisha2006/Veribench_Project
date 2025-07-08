module tb_behav_counter;
  // Inputs
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  reg [7:0] d;
  // Output
  wire [7:0] qd;
  // Instantiate the Behavioral Counter
  behav_counter uut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
  );
  initial begin
    // Clock generation
    clk = 0; forever #5 clk = ~clk;
    // Stimulus
    clear = 0;
    load = 0;
    up_down = 0;
    d = 8'hFF;
    #10;
    clear = 1;
    #10;
    load = 1;
    d = 8'h00;
    #10;
    up_down = 1;
    #100;
    up_down = 0;
    #100;
    load = 1;
    d = 8'hAA;
    #10;
    $finish;
  end
  // Monitoring
  initial begin
    $display("Time	clear	load	up_down	d	cnt");
    forever begin
      $display("%0d	%b	%b	%b	%b	%b", $time, clear, load, up_down, d, qd);
      #5;
    end
  end
endmodule