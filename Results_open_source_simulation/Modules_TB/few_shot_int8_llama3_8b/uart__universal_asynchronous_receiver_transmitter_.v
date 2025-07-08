module tb_uart_module;
// Parameters
parameter BAUD_RATE = 9600;  // Default baud rate is 9600
// Clock and reset signals
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
   .rx(1'b0),  // Connect RX pin to a constant '0'
   .tx(tx), 
   .data_in(data_in), 
   .data_out(data_out)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Generate a clock signal with a period of 10000000 (10 MHz) for 9600 baud rate
    forever begin
        clk = ~clk; #5; clk = ~clk; #5;
    end
    // Send some data through the UART
    data_in = 8'h12; #1000000;  // Send 0x12
    data_in = 8'h34; #1000000;  // Send 0x34
    data_in = 8'h56; #1000000;  // Send 0x56
    // Receive some data from the UART
    @(posedge clk);  // Wait for the first bit to be received
    $display("Received data: %h", data_out);
    @(posedge clk);  // Wait for the second bit to be received
    $display("Received data: %h", data_out);
    @(posedge clk);  // Wait for the third bit to be received
    $display("Received data: %h", data_out);
    // Finish the simulation
    $finish;
end
endmodule