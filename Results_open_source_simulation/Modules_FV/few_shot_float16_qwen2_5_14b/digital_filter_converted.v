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
  assert (@(negedge rst) disable iff (rst)
      ##[1:$] data_out[*] inside {[0:(2**DATA_WIDTH)-1]});

  // Property: Data out should reflect some expected behavior post-reset
  // This is a placeholder as actual behavior depends on implementation details
  assert (@(negedge rst) disable iff (rst)
      ##[1:$] data_out[*] !== data_in[*]);

  // Property: Ensure no undefined values during normal operation
  assert (@(posedge clk) disable iff (!rst)
      data_out[*] inside {[0:(2**DATA_WIDTH)-1]});

endmodule