module tb_bidir_pin;

  reg [0:0] dir;
  reg [0:0] data_out;
  wire [0:0] data_in;
  wire [0:0] pin;

  bidir_pin #(
    .WIDTH(1)
  ) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  property p_direction;
    @(posedge clk) dir == 1'b1 && pin == data_out;
  endproperty

  property p_direction_inverted;
    @(posedge clk) dir == 1'b0 && pin == 1'bz;
  endproperty

  assert property (p_direction);
  assert property (p_direction_inverted);

endmodule