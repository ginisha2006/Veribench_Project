module tb_bidir_pin #(parameter WIDTH = 1);

  // Inputs
  reg clk;
  reg dir;
  reg [WIDTH-1:0] data_out;

  // Outputs
  wire [WIDTH-1:0] pin;
  wire [WIDTH-1:0] data_in;

  // Instantiate the DUT
  bidir_pin #(.WIDTH(WIDTH)) UUT (
   .pin(pin),
   .dir(dir),
   .data_out(data_out),
   .data_in(data_in)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check direction control
  property p_dir_control;
    @(posedge clk) ((dir) => ($onehot(pin) && pin == data_out));
    @(posedge clk) (!dir => ($isunknown(pin)));
  endproperty
  assert property (p_dir_control);

  // Property: Check data_in when dir is low
  property p_data_in_low_dir;
    @(posedge clk) (!dir && data_in == {WIDTH{1'bz}});
  endproperty
  assert property (p_data_in_low_dir);

endmodule