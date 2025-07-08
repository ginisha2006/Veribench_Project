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
    // Initialize signals
    clk = 0;
    rst = 1;
    data_in = 0;
    
    // Clock generation process
    forever #5 clk = ~clk;
    
    // Reset active low
    rst = 0;
    #10 rst = 1;
    
    // Display headers
    $display("Time	rst	data_in	modulated_signal	demodulated_data");
    $monitor("%0d	%b	%b	%b	%b", $time, rst, data_in, modulated_signal, demodulated_data);
    
    // Test Cases
    data_in = 0; #20;
    data_in = {DATA_WIDTH{1'b1}}; #20;
    data_in = {8{1'b1}, 8{1'b0}}; #20;
    data_in = {8{1'b0}, 8{1'b1}}; #20;
    data_in = {DATA_WIDTH{1'b0}}; #20;
    data_in = {DATA_WIDTH{1'b1}}; #20;
    data_in = 'hABCD; #20;
    
    // Finish the simulation
    $finish;
end
endmodule