module tb_param_shift_reg;

  parameter WIDTH = 8;

  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] data_out;

  param_shift_reg #(WIDTH) dut (clk, rst, load, data_in, data_out);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  always @(posedge clk) begin
    prev_data_out = data_out;
  end

  always @(*) begin assert (@(posedge clk) data_out == data_in); end
  always @(*) begin assert (@(posedge clk) (load && data_out == data_in) || (!load && data_out == prev_data_out)); end

endmodule