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
  property p_correct_data_out;
    @(posedge clk) ((data_out == data_in) &&!rst);
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if tx is asserted when data_out is valid
  property p_correct_tx;
    @(posedge clk) (tx == 1'b1 && data_out!= 8'h00);
  endproperty
  assert property (p_correct_tx);

  // Property: Check if rx is propagated correctly
  property p_correct_rx;
    @(posedge clk) (rx == 1'b1 -> (data_out == rx));
  endproperty
  assert property (p_correct_rx);

endmodule