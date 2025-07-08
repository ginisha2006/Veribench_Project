module tb_bidir_pin #(parameter WIDTH = 1)();

  // Inputs
  reg clk;
  reg dir;
  reg [WIDTH-1:0] data_out;

  // Outputs
  wire [WIDTH-1:0] data_in;
  wire [WIDTH-1:0] pin;

  // Instantiate the DUT
  bidir_pin #( .WIDTH(WIDTH) ) UUT (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin assert (@(posedge clk) (pin == dir ? data_out : {WIDTH{1'bz}})); end

  always @(*) begin assert (@(posedge clk) (data_in == pin)); end

endmodule