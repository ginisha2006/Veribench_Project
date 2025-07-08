module tb_param_shift_reg #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg rst;
  reg load;
  reg [WIDTH-1:0] data_in;

  // Output
  wire [WIDTH-1:0] data_out;

  // Instantiate the DUT
  param_shift_reg #(.WIDTH(WIDTH)) UUT (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Reset should clear the register
  property p_reset_clears_register;
    @(posedge clk) (rst && !$past(rst)) |-> ##1 data_out == 0;
  endproperty
  assert property (p_reset_clears_register);

  // Property: Load should update the register with data_in
  property p_load_updates_register;
    @(posedge clk) (load && !$past(load)) |-> ##1 data_out == data_in;
  endproperty
  assert property (p_load_updates_register);

endmodule