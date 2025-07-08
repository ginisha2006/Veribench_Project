module tb_param_shift_reg;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;

  param_shift_reg #(WIDTH)(
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  property p_reset;
    @(posedge clk) data_out == 0;
  endproperty

  property p_load;
    @(posedge clk) (load && data_out == data_in);
  endproperty

  property p_shift;
    @(posedge clk) !load && data_out == {data_out[WIDTH-2:0], data_in[WIDTH-1]};
  endproperty

  assert property (p_reset);
  assert property (p_load);
  assert property (p_shift);

  always #5 clk = ~clk;

endmodule