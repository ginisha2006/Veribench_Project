module tb_behav_counter;
  // Inputs
  reg [7:0] d;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
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
    clk = 0;
    forever #5 clk = ~clk;
    // Stimulus
    clear = 0;
    load = 0;
    up_down = 1;
    d = 8'hFF;
    #100 clear = 1;
    #10 load = 1;
    d = 8'h0A;
    #100 up_down = 0;
    #100 $finish;
  end
  // Monitor output
  initial begin
    $display("Time	d	clear	load	up_down	cnt");
    $monitor("%0d	%b	%b	%b	%b	%b", $time, d, clear, load, up_down, qd);
  end
endmodule