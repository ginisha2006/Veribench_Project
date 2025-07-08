module tb_uart_module;
  // Parameters
  parameter BAUD_RATE = 9600;
  // Signals
  reg clk;
  reg rst;
  wire rx;
  wire tx;
  reg [7:0] data_in;
  wire [7:0] data_out;
  // Instantiate the UART Module
  uart_module #( .BAUD_RATE(BAUD_RATE) ) uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );
  // Clock Generation
  always #5 clk = ~clk;
  // Reset Pulse
  initial begin
    rst = 1;
    #10 rst = 0;
  end
  // Data Input Stimulus
  initial begin
    data_in = 8'hAA;
    #10 data_in = 8'hBB;
    #10 data_in = 8'hCC;
    #10 data_in = 8'hDD;
    #10 $finish;
  end
  // Monitor Signals
  initial begin
    $monitor("Time	clk	rst	rx	tx	data_in	data_out");
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, clk, rst, rx, tx, data_in, data_out);
  end
endmodule