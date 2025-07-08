module fft_module #(parameter DATA_WIDTH = 16, parameter FFT_POINTS = 1024)
(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg done
);

reg [31:0] twiddle_factors [FFT_POINTS/2-1:0];
reg [DATA_WIDTH-1:0] temp_re [FFT_POINTS/2-1:0];
reg [DATA_WIDTH-1:0] temp_im [FFT_POINTS/2-1:0];

always @(posedge clk) begin
    if (rst) begin
        done <= 0;
    end else begin
        if (start) begin
            done <= 0;
            for (int i = 0; i < FFT_POINTS/2; i++) begin
                temp_re[i] <= data_in;
                temp_im[i] <= 0;
            end
        end else if (!done) begin
            for (int i = 0; i < FFT_POINTS/2; i++) begin
                for (int j = 0; j < FFT_POINTS/2; j++) begin
                    int k = i + j;
                    if (k >= FFT_POINTS/2) k -= FFT_POINTS;
                    temp_re[k] <= temp_re[i] * cos(2*3.14159*(j*FFT_POINTS)/FFT_POINTS) - temp_im[i] * sin(2*3.14159*(j*FFT_POINTS)/FFT_POINTS);
                    temp_im[k] <= temp_re[i] * sin(2*3.14159*(j*FFT_POINTS)/FFT_POINTS) + temp_im[i] * cos(2*3.14159*(j*FFT_POINTS)/FFT_POINTS);
                end
            end
            done <= 1;
        end
    end
end

assign data_out = temp_re[0];

initial begin
    $display("Generating twiddle factors...");
    for (int i = 0; i < FFT_POINTS/2; i++) begin
        twiddle_factors[i] = 32'd0;
        if (i > 0) begin
            twiddle_factors[i] = 32'd1 << ((i % 2 == 0)? 15 : 14);
        end
    end
end

endmodule