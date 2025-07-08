module fft_module #(
    parameter int DATA_WIDTH = 16,
    parameter int FFT_POINTS = 1024
)(
    input logic clk,
    input logic rst,
    input logic start,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
    output logic done
);
    
endmodule