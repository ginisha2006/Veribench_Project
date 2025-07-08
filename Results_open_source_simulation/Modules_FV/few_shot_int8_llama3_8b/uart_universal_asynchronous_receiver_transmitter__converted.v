module tb_uart_module #(parameter BAUD_RATE = 9600)();

  // Inputs
  reg clk, rst;
  reg rx;
  reg [7:0] data_in;

  // Outputs
  wire tx;
  wire [7:0] data_out;

  // Instantiate the DUT
  uart_module #(.BAUD_RATE(BAUD_RATE)) UUT (
   .clk(clk),
   .rst(rst),
   .rx(rx),
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #10 clk = ~clk;

  // Property: Check if data_out is updated correctly
  always @(*) begin assert (@(posedge clk) ((data_out == data_in) &&!rst)); end

  // Property: Check if tx is asserted when data_out is valid
  always @(*) begin assert (@(posedge clk) (tx == 1'b1 && data_out!= 8'h00)); end

  // Property: Check if rx is propagated correctly
  always @(*) begin assert (@(posedge clk) (rx == 1'b1 -> (data_out == rx))); end

endmodule