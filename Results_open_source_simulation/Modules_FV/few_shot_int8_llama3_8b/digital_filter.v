module tb_digital_filter #(parameter DATA_WIDTH = 16, parameter COEFF_WIDTH = 16, parameter NUM_TAPS = 32);

  // Inputs
  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Coefficients
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

  // Instantiate the DUT
  digital_filter #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.NUM_TAPS(NUM_TAPS)) UUT (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .data_out(data_out),
   .coeff(coeff)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if data_out is updated correctly
  property p_correct_data_out;
    @(posedge clk) (data_out ==?); // Replace with actual implementation
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if data_out is reset correctly
  property p_reset_data_out;
    @(posedge rst) (data_out == 0); // Replace with actual implementation
  endproperty
  assert property (p_reset_data_out);

  // Property: Check if coefficients are used correctly
  property p_coeff_used;
    @(posedge clk) (?); // Replace with actual implementation
  endproperty
  assert property (p_coeff_used);

endmodule