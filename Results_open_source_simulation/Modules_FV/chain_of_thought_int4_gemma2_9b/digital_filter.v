module tb_digital_filter;

  parameter DATA_WIDTH = 16;
  parameter COEFF_WIDTH = 16;
  parameter NUM_TAPS = 32;

  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

  digital_filter #(
    .DATA_WIDTH(DATA_WIDTH),
    .COEFF_WIDTH(COEFF_WIDTH),
    .NUM_TAPS(NUM_TAPS)
  ) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
  );

  always #5 clk = ~clk;

  property valid_coeffs;
    @(posedge clk) coeff[0] != 0;
  endproperty

  property data_range;
    @(posedge clk) data_in >= 0 && data_in < 2**DATA_WIDTH;
  endproperty

  property output_range;
    @(posedge clk) data_out >= 0 && data_out < 2**DATA_WIDTH;
  endproperty

  assert property (valid_coeffs);
  assert property (data_range);
  assert property (output_range);


endmodule