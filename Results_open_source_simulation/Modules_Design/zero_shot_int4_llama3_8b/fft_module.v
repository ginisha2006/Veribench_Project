module fft_module(
    input wire clk,
    input wire rst,
    input wire start,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg done
);

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

reg [DATA_WIDTH-1:0] twiddle_factors [FFT_POINTS-1:0];
reg [DATA_WIDTH*2-1:0] complex_data [FFT_POINTS/2-1:0];

always @(posedge clk)
if (~rst) begin
    done <= 1'b0;
    if (start) begin
        // Initialize twiddle factors
        for (int i = 0; i < FFT_POINTS; i++) begin
            twiddle_factors[i] = $clogb2(i);
        end
        // Perform FFT
        for (int i = 0; i < FFT_POINTS/2; i++) begin
            complex_data[i] = {data_in[i*2], data_in[i*2+1]};
            for (int j = 0; j < FFT_POINTS/2; j++) begin
                if (j == 0 || j == FFT_POINTS/2-1) begin
                    complex_data[i] = complex_data[i];
                end else begin
                    complex_data[i] = complex_data[i] + twiddle_factors[j]*complex_data[i-j];
                end
            end
        end
        done <= 1'b1;
    end
end

assign data_out = complex_data[FFT_POINTS/2-1];

endmodule