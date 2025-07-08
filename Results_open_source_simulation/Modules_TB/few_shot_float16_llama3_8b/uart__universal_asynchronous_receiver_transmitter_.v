module tb_uart_module;
// Parameter
parameter BAUD_RATE = 9600;  // Default baud rate is 9600
// Clock and reset
reg clk;
reg rst;
// Input and output signals
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;
// Instantiate the UART Module
uart_module #(.BAUD_RATE(BAUD_RATE)) uut (
   .clk(clk), 
   .rst(rst), 
   .rx(1'b0),  // Connect RX pin to ground
   .tx(tx), 
   .data_in(data_in), 
   .data_out(data_out)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Generate clock signal
    forever begin
        #10 clk = ~clk;
    end
    // Monitor changes to outputs
    $monitor($time, " clk: %b, rst: %b, tx: %b, data_in: %b, data_out: %b", clk, rst, tx, data_in, data_out);
    // Test sending a byte
    data_in = 8'h12; #10000000;  // Send a byte with a delay of 10ms
    // Test receiving a byte
    data_in = 8'x00; #10000000;  // Receive a byte with a delay of 10ms
    // Finish the simulation
    $finish;
end
endmodule