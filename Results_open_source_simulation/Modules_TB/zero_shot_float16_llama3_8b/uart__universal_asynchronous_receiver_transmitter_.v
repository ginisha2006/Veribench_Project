module uart_tb;
parameter BAUD_RATE = 9600;

reg clk;
reg rst;
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;

uart_module uut (
   .clk(clk),
   .rst(rst),
   .rx(8'bx), // Don't care for RX input
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #100; // Wait for some time before starting the test
    rst = 1; // Reset the DUT
    #10; // Hold reset for 10 clock cycles
    rst = 0; // Release reset
    #100; // Wait for some time before sending data
    
    // Send a byte with all bits set
    data_in = 8'b11111111;
    repeat (10) @(posedge clk); // Send the byte 10 times at the baud rate
    data_in = 8'bx; // Clear the input
    
    // Send a byte with all bits cleared
    data_in = 8'00000000;
    repeat (10) @(posedge clk); // Send the byte 10 times at the baud rate
    data_in = 8'bx; // Clear the input
    
    // Check the received data
    $monitor($time, "Received data: %b", data_out);
    
    #1000; // Run for 1 second
    $finish; // Finish the simulation
end

always #5 clk = ~clk; // Generate a clock signal

initial begin
    clk = 0; // Initialize the clock low
    forever #50 clk = ~clk; // Clock period is 10ns
end

endmodule