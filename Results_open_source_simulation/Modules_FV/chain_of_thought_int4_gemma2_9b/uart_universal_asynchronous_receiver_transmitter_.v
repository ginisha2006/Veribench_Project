module tb_uart_module(
  );

  uart_module dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  property p_valid_baud_rate;
    @(posedge clk)
      $past(clk) != clk;
  endproperty

  property p_data_in_to_out;
    @(posedge clk)
      data_out == data_in;
  endproperty

  assert property (p_valid_baud_rate);
  assert property (p_data_in_to_out);

  always #5 clk = ~clk;

endmodule