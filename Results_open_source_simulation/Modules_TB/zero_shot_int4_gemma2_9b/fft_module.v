module fft_module_tb #(
    parameter DATA_WIDTH = 16,
    parameter FFT_POINTS = 1024
);

  reg clk;
  reg rst;
  reg start;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
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
    data_in = 0;
    #100 start = 1;
    data_in = 16'hAAAA;
    #100 start = 0;
    #1000 $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t clk=%b rst=%b start=%b data_in=%h data_out=%h done=%b", $time, clk, rst, start, data_in, data_out, done);
  end

endmodule