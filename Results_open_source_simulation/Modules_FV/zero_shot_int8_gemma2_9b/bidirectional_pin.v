module tb_bidir_pin;

  parameter WIDTH = 1;

  reg [WIDTH-1:0] data_out;
  reg dir;
  wire [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] pin;

  bidir_pin #(WIDTH) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  property p_direction;
    @(posedge clk)
      (dir == 1'b1)  -> (pin == data_out);
    @(posedge clk)
      (dir == 1'b0)  -> (pin == {WIDTH{1'bz}});
  endproperty

  assert property(p_direction);

endmodule