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

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Assertions (placeholder - add specific assertions based on UART functionality)
  always @(*) begin assert (// ...); end

  always @(*) begin assert (// ...); end

endmodule