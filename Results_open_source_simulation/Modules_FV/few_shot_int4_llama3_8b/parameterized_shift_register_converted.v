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
  always @(*) begin assert (@(posedge clk) ($rose(rst) |=> data_out == 0)); end

  // Property: Load should update data_out with data_in
  always @(*) begin assert (@(posedge clk) ((load &&!rst) |=> data_out == data_in)); end

  // Property: Data_out remains unchanged when not loaded
  always @(*) begin assert (@(posedge clk) (!load &&!rst |=> data_out === data_out)); end

endmodule