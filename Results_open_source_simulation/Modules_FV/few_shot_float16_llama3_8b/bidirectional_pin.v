module tb_bidir_pin #(parameter WIDTH = 1);

  // Inputs
  reg clk;
  reg [WIDTH-1:0] data_out;
  reg dir;

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

  // Property: Check if pin is driven by data_out when dir is high
  property p_drive_pin_by_data_out;
    @(posedge clk) ((dir && pin == data_out) | (!dir && pin == {WIDTH{1'bz}}));
  endproperty
  assert property (p_drive_pin_by_data_out);

  // Property: Check if data_in is driven by pin
  property p_drive_data_in_by_pin;
    @(posedge clk) (data_in == pin);
  endproperty
  assert property (p_drive_data_in_by_pin);

endmodule