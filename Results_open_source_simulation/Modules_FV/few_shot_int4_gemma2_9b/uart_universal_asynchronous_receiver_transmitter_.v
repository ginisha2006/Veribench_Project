module tb_uart_module #(parameter BAUD_RATE = 9600)();

  // Inputs
  reg clk;
  reg rst;
  reg rx;
  reg [7:0] data_in;

  // Outputs
  wire tx;
  wire [7:0] data_out;

  // Instantiate the UART module
  uart_module #( .BAUD_RATE(BAUD_RATE) ) UUT (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset assertion
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Properties (placeholder - add your specific UART functionality assertions here)
  property p_tx_data;
    @(posedge clk) (tx == 1'b0 || tx == 1'b1); // Example: Ensure valid TX signal levels
  endproperty
  assert property (p_tx_data);

  property p_rx_data;
    @(posedge clk) (rx == 1'b0 || rx == 1'b1); // Example: Ensure valid RX signal levels
  endproperty
  assert property (p_rx_data);


endmodule