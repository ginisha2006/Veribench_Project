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

  // Assertions

  // Property: Output should be stable when reset is low
  property p_stable_when_not_reset;
    @(posedge clk) disable iff (!rst) !($changed(data_out));
  endproperty
  assert property (p_stable_when_not_reset);

  // Property: Output should change when reset goes high after being low
  property p_changes_on_reset_release;
    @(posedge clk) disable iff (!rst) $rose(rst) |-> ##1 $stable(data_out);
  endproperty
  assert property (p_changes_on_reset_release);

endmodule