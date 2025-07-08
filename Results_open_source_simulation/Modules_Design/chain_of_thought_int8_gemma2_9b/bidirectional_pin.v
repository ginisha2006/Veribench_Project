module bidir_pin (
  inout pin[WIDTH-1:0],
  input dir,
  input [WIDTH-1:0] data_out,
  output reg [WIDTH-1:0] data_in
);

  always @(dir or data_out) begin
    if (dir) begin
      data_in = data_out;
    end else begin
      data_in = pin;
    end
  end

endmodule