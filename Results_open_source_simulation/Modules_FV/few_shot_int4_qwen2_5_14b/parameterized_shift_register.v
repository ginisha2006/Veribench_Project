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
  property p_reset_clears_data;
    @(posedge rst) disable iff (!rst && !load)
      $rose(rst) |-> (data_out === 0);
  endproperty
  assert property (p_reset_clears_data);

  // Property: Load should update the shift register with data_in
  property p_load_updates_data;
    @(posedge clk) disable iff (!rst && !load)
      $rose(load) |-> (data_out === data_in);
  endproperty
  assert property (p_load_updates_data);

endmodule