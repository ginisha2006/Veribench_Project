module tb_uart_module;
// Parameter
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
   .rx(1'b0),  // No RX signal in this testbench
   .tx(tx), 
   .data_in(data_in), 
   .data_out(data_out)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 1; #10; rst = 0;
    // Generate clock signal with period matching the baud rate
    forever begin
        clk = ~clk; #10000000/BaudRate;  // Baud rate is 1/10000000th of the clock period
    end
    // Monitor changes to inputs and outputs
    $monitor("%t %b %b %b %b", $time, clk, rst, data_in, data_out);
    // Test transmission of a byte
    data_in = 8'h12; #10000000/Baud_rate;  // Send a byte over the TX line
    // Finish the simulation
    $finish;
end
endmodule