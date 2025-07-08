module bidir_pin (
  inout pin[WIDTH-1:0],
  input dir,
  input [WIDTH-1:0] data_out,
  output [WIDTH-1:0] data_in
);

  assign data_in = dir ? data_out : pin;
  assign pin = dir ? pin : data_in;

endmodule