module tb_digital_filter #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter NUM_TAPS = 32
)();

  // Inputs
  reg clk, rst;
  reg [DATA_WIDTH-1:0] data_in;
  reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  digital_filter #(
    .DATA_WIDTH(DATA_WIDTH),
    .COEFF_WIDTH(COEFF_WIDTH),
    .NUM_TAPS(NUM_TAPS)
  ) UUT (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Data out should stabilize after reset deassertion
  property p_stabilize_after_reset;
    @(negedge rst) disable iff (rst)
      ##[1:$] (data_out !== data_out[*1]);
  endproperty
  assert property (p_stabilize_after_reset);

  // Property: Output should not change when coefficients do not change
  property p_output_stable_when_coefficients_stable;
    @(posedge clk) disable iff (rst)
      (coeff != coeff[*1]) |-> (data_out !== data_out[*1]);
  endproperty
  assert property (p_output_stable_when_coefficients_stable);

  // Property: Output should not exceed data width range
  property p_data_out_range;
    @(posedge clk) disable iff (rst)
      data_out < {{(DATA_WIDTH-1){1'b0}}, 1'b1};
  endproperty
  assert property (p_data_out_range);

endmodule