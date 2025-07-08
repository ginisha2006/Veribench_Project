module tb_param_shift_reg #(parameter WIDTH = 8);

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

  // Property: Check reset behavior
  always @(*) begin assert (@(posedge clk) disable iff (!rst) (data_out == 0)); end

  // Property: Check load behavior
  always @(*) begin assert (@(posedge clk) disable iff (!load) (data_out == data_in)); end

  // Property: Check non-load behavior
  always @(*) begin assert (@(posedge clk) disable iff (load) ((data_out == data_out) && (data_out!= 0))); end

endmodule