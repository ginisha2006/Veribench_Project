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
            done <= 1;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        temp_re <= 0;
        temp_im <= 0;
    end else begin
        if (start) begin
            for (int i = 0; i < FFT_POINTS/2; i = i + 1) begin
                temp_re[i] <= data_in;
                temp_im[i] <= 0;
            end
        end else begin
            for (int i = 1; i < FFT_POINTS/2; i = i + 1) begin
                for (int j = 0; j < i; j = j + 1) begin
                    int k = i - j;
                    temp_re[k] <= temp_re[k] - temp_im[j];
                    temp_im[k] <= temp_im[j] + temp_re[j];
                end
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        data_out <= 0;
    end else begin
        if (done) begin
            for (int i = 0; i < FFT_POINTS/2; i = i + 1) begin
                data_out <= temp_re[i];
            end
        end
    end
end

assign twiddle_factors[0] = 32'd1;
for (int i = 1; i < FFT_POINTS/2; i = i + 1) begin
    assign twiddle_factors[i] = (i % 2 == 0)? 32'd1 : ((32'd1 << 15) >> (15 - (i/2)));
end

always @(posedge clk) begin
    if (rst) begin
        for (int i = 0; i < FFT_POINTS/2; i = i + 1) begin
            temp_re[i] <= 0;
            temp_im[i] <= 0;
        end
    end else begin
        if (start) begin
            for (int i = 0; i < FFT_POINTS/2; i = i + 1) begin
                temp_re[i] <= data_in;
                temp_im[i] <= 0;
            end
        end else begin
            for (int i = 1; i < FFT_POINTS/2; i = i + 1) begin
                for (int j = 0; j < i; j = j + 1) begin
                    int k = i - j;
                    temp_re[k] <= temp_re[k] - twiddle_factors[j][15:0]*temp_im[j];
                    temp_im[k] <= temp_im[j] + twiddle_factors[j][15:0]*temp_re[j];
                end
            end
        end
    end
end

endmodule