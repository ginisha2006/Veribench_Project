module fft_module_tb;

  reg clk;
  reg rst;
  reg start;
  reg [15:0] data_in;
  wire [15:0] data_out;
  wire done;

  fft_module dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    start = 0;
    #10 start = 1;
    data_in = 16'hAAAA;
    #100 start = 0;
    $monitor("Time: %t ns, data_in: %h, data_out: %h, done: %b", $time, data_in, data_out, done);
  end

endmodule