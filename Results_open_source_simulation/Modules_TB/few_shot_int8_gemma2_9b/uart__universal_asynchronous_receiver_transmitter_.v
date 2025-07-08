module tb_uart_module;

  // Parameters
  parameter BAUD_RATE = 9600;

  // Signals
  reg clk;
  reg rst;
  reg rx;
  wire tx;
  reg [7:0] data_in;
  wire [7:0] data_out;

  // Instantiate the UART module
  uart_module #( .BAUD_RATE(BAUD_RATE) ) uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Data input stimulus
  initial begin
    data_in = 8'hAA;
    #10 data_in = 8'hBB;
    #10 data_in = 8'hCC;
    #10 data_in = 8'hDD;
    #10 $finish;
  end

  // RX stimulus
  initial begin
    rx = 0;
    #10 rx = 1;
    #10 rx = 0;
  end

  // Monitor signals
  initial begin
    $monitor("Time: %0t clk: %b rst: %b rx: %b tx: %b data_in: %h data_out: %h", $time, clk, rst, rx, tx, data_in, data_out);
  end

endmodule