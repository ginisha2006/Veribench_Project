module tb_bidir_pin #(
    parameter WIDTH = 1
)(
    inout [WIDTH-1:0] pin,
    input dir,
    input [WIDTH-1:0] data_out,
    output [WIDTH-1:0] data_in
);

  property p_data_direction;
    @(posedge clk)
      (dir == 1'b1) -> (pin == data_out);
    (dir == 1'b0) -> (pin == {WIDTH{1'bz}});
  endproperty

  assert property (p_data_direction);

endmodule