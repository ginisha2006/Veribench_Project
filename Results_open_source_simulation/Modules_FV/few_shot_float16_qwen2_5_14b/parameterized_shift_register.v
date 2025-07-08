module tb_param_shift_reg #(parameter WIDTH = 8)();

  // Inputs
  reg clk, rst, load;
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

  // Property: Data out should be reset to zero when rst is high
  property p_reset;
    @(posedge clk) (rst && !$isunknown(data_out)) |-> ##1 data_out == 0;
  endproperty
  assert property (p_reset);

  // Property: Data out should match data_in when load is high
  property p_load;
    @(posedge clk) (load && !$isunknown(data_in)) |-> ##1 data_out == data_in;
  endproperty
  assert property (p_load);

endmodule