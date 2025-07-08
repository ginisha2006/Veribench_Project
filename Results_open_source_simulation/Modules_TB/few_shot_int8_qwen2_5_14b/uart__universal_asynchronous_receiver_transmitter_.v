module tb_uart_module;
// Parameters
parameter BAUD_RATE = 9600;

// Clock generation process
reg clk;
always #5 clk = ~clk;

// Inputs
reg rst;
reg rx;
reg [7:0] data_in;
// Outputs
wire tx;
wire [7:0] data_out;

// Instantiate the UART Module
uart_module #(.BAUD_RATE(BAUD_RATE)) uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    rx = 1;
    data_in = 8'b0000_0000;
    
    // Display the header for the output
    $display("Time	rst	rx	tx	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, rx, tx, data_out);
    
    // Apply reset
    #10 rst = 0;
    
    // Send data
    data_in = 8'hAA; // Sending 'A'
    rx = 0; #100; rx = 1; #100;
    
    data_in = 8'hBB; // Sending 'B'
    rx = 0; #100; rx = 1; #100;
    
    data_in = 8'hCC; // Sending 'C'
    rx = 0; #100; rx = 1; #100;
    
    // Wait for some time to observe the response
    #1000;
    
    // Finish the simulation
    $finish;
end
endmodule