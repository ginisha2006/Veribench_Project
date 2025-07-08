module tb_param_shift_reg;

  parameter WIDTH = 8;

  logic clk;
  logic rst;
  logic load;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;

  param_shift_reg dut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  assert (@(posedge clk)
      (rst == 1'b1)  -> data_out == 0;
    @(posedge clk)
      (rst == 1'b0 && load == 1'b1)  -> data_out == data_in;
    @(posedge clk)
      (rst == 1'b0 && load == 1'b0)  -> data_out == {WIDTH{data_out[WIDTH-2]}});

endmodule