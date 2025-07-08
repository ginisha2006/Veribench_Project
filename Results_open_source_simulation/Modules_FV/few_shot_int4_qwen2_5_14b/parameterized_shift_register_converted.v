module tb_param_shift_reg #(parameter WIDTH = 8)();

  // Inputs
  reg clk, rst, load;
  reg [WIDTH-1:0] data_in;

  // Output
  wire [WIDTH-1:0] data_out;

  // Instantiate the DUT
  param_shift_reg #(.WIDTH(WIDTH)) UUT (
    .clk(clk),
    .rst(rst),
    .load(load),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = !clk;

  // Properties

  // Property: Reset should clear the shift register
  assert (@(posedge rst) disable iff (!rst && !load)
      $rose(rst) |-> (data_out === 0));

  // Property: Load should update the shift register with data_in
  assert (@(posedge clk) disable iff (!rst && !load)
      $rose(load) |-> (data_out === data_in));

endmodule