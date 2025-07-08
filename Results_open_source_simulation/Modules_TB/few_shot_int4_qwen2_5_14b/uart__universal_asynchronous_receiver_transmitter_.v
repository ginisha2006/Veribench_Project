module tb_uart_module;

// Parameters
parameter BAUD_RATE = 9600;

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
    // Initialize clock
    clk <= 0;
    forever #5 clk = ~clk; // Clock period of 10 ns
    
    // Reset the system
    rst <= 1;
    #20;
    rst <= 0;
    
    // Send some data over RX line
    data_in <= 8'hAA;
    rx <= 1; // Idle state
    #100;
    rx <= 0; // Start bit
    #100;
    rx <= 1; // Data bits
    #100;
    rx <= 0;
    #100;
    rx <= 1;
    #100;
    rx <= 0;
    #100;
    rx <= 1;
    #100;
    rx <= 0;
    #100;
    rx <= 1;
    #100;
    rx <= 0;
    #100;
    rx <= 1;
    #100;
    rx <= 0;
    #100;
    rx <= 1; // Stop bit
    #100;
    rx <= 1; // Back to idle
    
    // Wait for response on TX line
    #200;
    
    // Check if data was received correctly
    if (data_out == 8'hAA) begin
        $display("Data received correctly: %h", data_out);
    end else begin
        $display("Error in receiving data: %h", data_out);
    end
    
    // Finish the simulation
    $finish;
end

endmodule