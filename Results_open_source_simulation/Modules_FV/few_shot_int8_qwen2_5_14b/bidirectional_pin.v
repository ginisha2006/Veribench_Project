module tb_bidir_pin #(
    parameter WIDTH = 1
)();

  // Inputs
  reg clk;
  reg dir;
  reg [WIDTH-1:0] data_out;

  // Bidirectional pin
  wire [WIDTH-1:0] pin;

  // Outputs
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

  // Properties
  property p_data_out_drives_pin_when_dir_is_high;
    @(posedge clk) disable iff (!dir) (pin == data_out);
  endproperty
  assert property (p_data_out_drives_pin_when_dir_is_high);

  property p_pin_is_z_or_equal_to_data_out_when_dir_is_low;
    @(posedge clk) disable iff (dir) (|(pin) |-> (pin === data_out));
  endproperty
  assert property (p_pin_is_z_or_equal_to_data_out_when_dir_is_low);

  property p_data_in_matches_pin;
    @(posedge clk) (data_in == pin);
  endproperty
  assert property (p_data_in_matches_pin);

endmodule