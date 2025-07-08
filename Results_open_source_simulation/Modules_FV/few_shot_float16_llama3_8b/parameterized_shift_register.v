module tb_param_shift_reg #(parameter WIDTH = 8);

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

  // Property: Check reset behavior
  property p_reset_behavior;
    @(posedge clk) (rst &&!load) |=> (data_out == 0);
  endproperty
  assert property (p_reset_behavior);

  // Property: Check load behavior
  property p_load_behavior;
    @(posedge clk) (load &&!rst) |=> (data_out == data_in);
  endproperty
  assert property (p_load_behavior);

  // Property: Check non-load behavior
  property p_non_load_behavior;
    @(posedge clk) (!load &&!rst) |=> (data_out === data_out);
  endproperty
  assert property (p_non_load_behavior);

endmodule