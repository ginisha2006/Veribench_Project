module tb_param_shift_reg #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;

  // Output
  wire [WIDTH-1:0] data_out;

  // Instantiate the DUT
  param_shift_reg #( .WIDTH(WIDTH) ) UUT (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_reset_behavior;
    @(posedge clk)
      (rst == 1'b1)  == (data_out == 0);
  endproperty
  assert property (p_reset_behavior);

  property p_load_behavior;
    @(posedge clk)
      (load == 1'b1)  == (data_out == data_in);
  endproperty
  assert property (p_load_behavior);

endmodule