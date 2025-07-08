module tb_uart_module(
  );

  parameter BAUD_RATE = 9600;

  reg clk;
  reg rst;
  reg rx;
  wire tx;
  reg [7:0] data_in;
  wire [7:0] data_out;

  uart_module dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  property data_in_to_data_out;
    @(posedge clk) data_out == data_in;
  endproperty

  assert property(data_in_to_data_out);

endmodule