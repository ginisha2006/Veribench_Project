module tb_uart_module;

// Parameters
parameter BAUD_RATE = 9600;

// Clock period calculation based on baud rate
parameter CLK_PERIOD_NS = 1000000000 / BAUD_RATE * 16; // Assuming 16 clock cycles per bit time

// Inputs
reg clk;
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
    clk <= 0;
    rst <= 1;
    rx <= 1;
    data_in <= 8'hFF;
    // Display the header for the output
    $display("Time	rst	rx	tx	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%h	%h", $time, rst, rx, tx, data_in, data_out);
    // Start clock generation
    fork
        forever begin
            #((CLK_PERIOD_NS / 2) / 2); clk = ~clk;
        end
    join_none
    
    // Apply reset
    rst = 0;
    #10 rst = 1;
    
    // Send some data over RX line
    data_in = 8'hA5;
    rx = 0; // Start bit
    #((CLK_PERIOD_NS * 10));
    for(int i=7; i>=0; i--) begin
        rx = data_in[i];
        #((CLK_PERIOD_NS * 10));
    end
    rx = 1; // Stop bit
    #((CLK_PERIOD_NS * 10));
    
    // Wait for data to be received
    #((CLK_PERIOD_NS * 100));
    
    // Check if data was correctly received
    if(data_out == 8'hA5) $display("Data received successfully!");
    else $display("Error in receiving data.");
    
    // Finish the simulation
    $finish;
end

endmodule