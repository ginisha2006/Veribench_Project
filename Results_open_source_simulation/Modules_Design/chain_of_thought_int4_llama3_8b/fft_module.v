module fft_module #(
    parameter DATA_WIDTH = 16,
    parameter FFT_POINTS = 1024
) (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg done
);