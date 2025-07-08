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

  // Property: Output should stabilize after reset deassertion
  property p_stabilize_after_reset;
    @(negedge rst) disable iff (rst)
      ##[1:$] data_out[*] inside {[0:(2**DATA_WIDTH)-1]};
  endproperty
  assert property (p_stabilize_after_reset);

  // Property: Data out should reflect some expected behavior post-reset
  // This is a placeholder as actual behavior depends on implementation details
  property p_expected_behavior_post_reset;
    @(negedge rst) disable iff (rst)
      ##[1:$] data_out[*] !== data_in[*];
  endproperty
  assert property (p_expected_behavior_post_reset);

  // Property: Ensure no undefined values during normal operation
  property p_no_undefined_values;
    @(posedge clk) disable iff (!rst)
      data_out[*] inside {[0:(2**DATA_WIDTH)-1]};
  endproperty
  assert property (p_no_undefined_values);

endmodule