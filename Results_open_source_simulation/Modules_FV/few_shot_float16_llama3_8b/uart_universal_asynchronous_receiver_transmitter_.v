module tb_uart_module #(parameter BAUD_RATE = 9600);

  // Inputs
  reg clk, rst;
  reg rx;
  wire tx;
  reg [7:0] data_in;
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
    @(posedge clk) ((data_out == 8'h00) |-> (!rst &&!rx));
  endproperty
  assert property (p_correct_data_out);

  // Property: Check if data_in is propagated correctly
  property p_propagate_data_in;
    @(posedge clk) ((!rst && rx) -> (data_out == data_in));
  endproperty
  assert property (p_propagate_data_in);

  // Property: Check if tx is asserted when data_out is valid
  property p_tx_assertion;
    @(posedge clk) ((!rst &&!rx && data_out!= 8'h00) -> tx);
  endproperty
  assert property (p_tx_assertion);

endmodule