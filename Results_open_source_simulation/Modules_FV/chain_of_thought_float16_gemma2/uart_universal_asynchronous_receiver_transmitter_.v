module tb_uart_module(
  );

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

  property p_data_in_to_out;
    @(posedge clk) data_out == data_in;
  endproperty

  assert property (p_data_in_to_out);

endmodule