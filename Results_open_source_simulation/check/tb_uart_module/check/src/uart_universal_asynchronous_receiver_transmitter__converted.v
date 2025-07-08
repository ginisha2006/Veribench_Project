module tb_uart_module #(parameter BAUD_RATE = 9600);

  // Inputs
  reg clk;
  reg rst;
  reg rx;
  reg [7:0] data_in;

  // Outputs
  wire tx;
  wire [7:0] data_out;

  // Instantiate the UART module
  uart_module #(BAUD_RATE) dut (
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

  // Reset pulse
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Assertions
  // ... (Add assertions based on UART functionality)

endmodule