module tb_param_shift_reg;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;

  param_shift_reg #(WIDTH) dut (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(data_out) == data_in |-> load && !rst);
  assert (@(posedge clk)
      rst -> data_out == 0);

endmodule