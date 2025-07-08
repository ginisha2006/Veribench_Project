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
    @(posedge clk) dir |-> pin === data_out;
  endproperty
  assert property (p_data_out_drives_pin_when_dir_is_high);

  property p_pin_z_on_low_dir;
    @(posedge clk) !dir |-> pin === {WIDTH{1'bz}};
  endproperty
  assert property (p_pin_z_on_low_dir);

  property p_data_in_matches_pin;
    @(posedge clk) data_in === pin;
  endproperty
  assert property (p_data_in_matches_pin);

endmodule