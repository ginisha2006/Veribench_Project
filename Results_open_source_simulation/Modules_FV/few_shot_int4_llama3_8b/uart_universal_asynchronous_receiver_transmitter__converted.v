module tb_uart_module #(parameter BAUD_RATE = 9600);

  // Inputs
  reg clk;
  reg rst;
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

  // Clock generation
  localparam CLOCK_PERIOD = 10000000; // Assuming 10 MHz clock
  integer i;
  initial begin
    clk = 0;
    forever begin
      #((CLOCK_PERIOD / 2) - 1) clk = ~clk;
    end
  end

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // RX stimulus
  task send_data(input [7:0] data);
    integer i;
    for (i = 0; i < 8; i++) begin
      rx = (data[i] << (7-i-1));
      #((CLOCK_PERIOD / BAUD_RATE) * 10); // Send one bit every 10 bits times the baud rate
    end
  endtask

  // Assertions
  always @(*) begin assert (@(posedge clk) (data_out == data_in)); end

  initial begin
    send_data(8'h12); // Send some data
  end

endmodule