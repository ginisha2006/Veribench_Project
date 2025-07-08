module tb_behav_counter;
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  reg [7:0] d;
  wire [7:0] qd;
  behav_counter dut (.d(d), .clk(clk), .clear(clear), .load(load), .up_down(up_down), .qd(qd));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize signals
    clear = 1'b1;
    load = 1'b0;
    up_down = 1'b1;
    d = 8'hFF;

    #10 clear = 1'b0; // Reset counter
    #10 load = 1'b1; // Load initial value
    #10 clear = 1'b1; // Clear reset
    #10 up_down = 1'b0; // Down count
    #10 up_down = 1'b1; // Up count
    #10 $finish;
  end

  // Monitor counter value
  always @(posedge clk) begin
    $display("Time %0d: clk=%b, clear=%b, load=%b, up_down=%b, d=%b, cnt=%b", $time, clk, clear, load, up_down, d, qd);
  end

endmodule