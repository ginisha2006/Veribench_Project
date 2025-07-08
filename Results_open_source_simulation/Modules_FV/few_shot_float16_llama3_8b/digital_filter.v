module tb_digital_filter #(parameter DATA_WIDTH = 16, parameter COEFF_WIDTH = 16, parameter NUM_TAPS = 32);

  // Inputs
  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

  // Output
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
  always #5 clk = ~clk;

  // Property: Check if data_out is updated correctly
  property p_correct_data_out;
    @(posedge clk) ((rst) |=> (data_out === 0));
    @(posedge clk) (~rst &&!($stable(data_in)) => (data_out === data_in));
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if data_out remains unchanged when rst is high
  property p_rst_hold;
    @(posedge clk) (rst &&!($stable(data_in)) => (data_out === 0));
  endproperty
  assert property (p_rst_hold);

endmodule