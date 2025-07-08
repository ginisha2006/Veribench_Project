module tb_mod_demod;
// Parameters
parameter DATA_WIDTH = 16;

// Inputs
reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in;

// Outputs
wire [DATA_WIDTH-1:0] modulated_signal;
wire [DATA_WIDTH-1:0] demodulated_data;

// Instantiate the Modulation and Demodulation module
mod_demod #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	data_in	modulated_signal	demodulated_data");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, data_in, modulated_signal, demodulated_data);
    
    // Reset the system
    rst = 1; #20; rst = 0;
    
    // Test various data inputs
    data_in = 0; #20;
    data_in = 'hFFFF; #20;
    data_in = 'hAAAA; #20;
    data_in = 'h5555; #20;
    data_in = 'h1234; #20;
    
    // Finish the simulation
    $finish;
end
endmodule