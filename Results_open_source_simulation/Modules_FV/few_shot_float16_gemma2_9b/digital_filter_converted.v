module tb_digital_filter #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter NUM_TAPS = 32
)();

  // Inputs
  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Coefficient initialization (example)
  initial begin
    $readmemh("coeffs.txt", coeff);
  end

  // Assertions (placeholder - add your specific assertions here)
  // ...


endmodule