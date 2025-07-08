module tb_param_shift_reg;

  parameter WIDTH = 8;

  logic clk;
  logic rst;
  logic load;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;

  param_shift_reg #(WIDTH) dut (clk, rst, load, data_in, data_out);

  property p_load;
    @(posedge clk) data_out == data_in;
  endproperty

  property p_reset;
    @(posedge clk) data_out == 0;
  endproperty

  assert property(p_load);
  assert property(p_reset);

endmodule