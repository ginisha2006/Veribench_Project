module tb_bidir_pin(
  );

  reg [0:0] pin;
  reg dir;
  reg [0:0] data_out;
  wire [0:0] data_in;

  bidir_pin #(
    .WIDTH(1)
  ) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  property bidirectional_pin_prop;
    @(posedge clk)
      $past(dir) == 1'b0 && pin == 1'bz ||
      $past(dir) == 1'b1 && pin == data_out;
  endproperty

  assert property(bidirectional_pin_prop);

endmodule