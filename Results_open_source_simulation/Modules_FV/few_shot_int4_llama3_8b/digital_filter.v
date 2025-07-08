module tb_digital_filter #(parameter DATA_WIDTH = 16, parameter COEFF_WIDTH = 16, parameter NUM_TAPS = 32);

  // Inputs
  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

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
  always #10 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #20 rst = 0;
  end

  // Property: Check if data_out is updated correctly
  property p_correct_data_out;
    @(posedge clk) (data_out == data_in);
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if data_out remains unchanged during reset
  property p_reset_data_out;
    @(posedge clk) ($rose(rst) |=> data_out == 0);
  endproperty
  assert property (p_reset_data_out);

  // Property: Check if data_out is updated correctly with coefficients
  property p_coefficient_update;
    @(posedge clk) (data_out == data_in + coeff[0]);
  endproperty
  assert property (p_coefficient_update);

endmodule