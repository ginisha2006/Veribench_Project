module tb_bidir_pin(
  );

  parameter WIDTH = 1;

  logic [WIDTH-1:0] pin;
  logic dir;
  logic [WIDTH-1:0] data_out;
  logic [WIDTH-1:0] data_in;

  bidir_pin #(WIDTH) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  assert (@(posedge clk)
    (dir == 1'b1)  -> (pin == data_out);
    @(posedge clk)
    (dir == 1'b0)  -> (pin == {WIDTH{1'bz}}));

endmodule