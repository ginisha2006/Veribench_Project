module tb_param_shift_reg;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;

  param_shift_reg #(WIDTH) dut (clk, rst, load, data_in, data_out);

  always #5 clk = ~clk;

  assert (@(posedge clk)
      (rst == 1'b1)  -> data_out == 0;
    @(posedge clk)
      (rst == 1'b0) && (load == 1'b1) -> data_out == data_in);

endmodule