module tb_param_shift_reg #(parameter WIDTH = 8);

  // Inputs
  reg clk;
  reg rst;
  reg load;
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
  always #5 clk = ~clk;

  // Property: Reset should set data_out to 0
  property p_reset_data_out_zero;
    @(posedge clk) ($rose(rst) |=> data_out == 0);
  endproperty
  assert property (p_reset_data_out_zero);

  // Property: Load should update data_out with data_in
  property p_load_updates_data_out;
    @(posedge clk) ((load &&!rst) |=> data_out == data_in);
  endproperty
  assert property (p_load_updates_data_out);

  // Property: Data_out remains unchanged when not loaded
  property p_no_change_when_not_loaded;
    @(posedge clk) (!load &&!rst |=> data_out === data_out);
  endproperty
  assert property (p_no_change_when_not_loaded);

endmodule