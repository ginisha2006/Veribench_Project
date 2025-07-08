module tb_fsm_1100();

  // Inputs
  reg clk;
  reg rst;
  reg bit_in;

  // Output
  wire pattern_detected;

  // Instantiate the DUT
  fsm_1100 UUT (
   .clk(clk),
   .rst(rst),
   .bit_in(bit_in),
   .pattern_detected(pattern_detected)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Pattern detection
  always @(*) begin assert (@(posedge clk) (pattern_detected == (bit_in == 0))); end

  // Property: State machine behavior
  always @(*) begin assert (@(posedge clk) ((bit_in) === (state == S1) | (bit_in) === (state == S2) | (bit_in) === (state == S3))); end

  // Property: Correct transition from S0 to S1
  always @(*) begin assert (@(posedge clk) (rst || (state == S0 && bit_in) === (next_state == S1))); end

  // Property: Correct transition from S1 to S2
  always @(*) begin assert (@(posedge clk) (rst || (state == S1 && bit_in) === (next_state == S2))); end

  // Property: Correct transition from S2 to S3
  always @(*) begin assert (@(posedge clk) (rst || (state == S2 && bit_in) === (next_state == S3))); end

  // Property: Correct transition from S3 back to S0
  always @(*) begin assert (@(posedge clk) (rst || (state == S3 &&!bit_in) === (next_state == S0))); end

endmodule