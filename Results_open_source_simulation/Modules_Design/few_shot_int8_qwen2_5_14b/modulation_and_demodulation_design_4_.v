module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] internal_signal;

always @(posedge clk or posedge rst)
    if(rst)
        internal_signal <= 0;
    else
        internal_signal <= data_in;

assign modulated_signal = ~internal_signal; // Simple example of modulation

always @(posedge clk or posedge rst)
    if(rst)
        demodulated_data <= 0;
    else
        demodulated_data <= ~modulated_signal; // Simple example of demodulation

endmodule