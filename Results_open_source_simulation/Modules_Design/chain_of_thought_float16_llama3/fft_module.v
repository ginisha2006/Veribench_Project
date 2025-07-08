module fft_module #(parameter DATA_WIDTH = 16, FFT_POINTS = 1024)
    (
        input wire clk,
        input wire rst,
        input wire start,
        input wire [DATA_WIDTH-1:0] data_in,
        output reg [DATA_WIDTH-1:0] data_out,
        output reg done
    );

    reg [DATA_WIDTH-1:0] temp_data [0:FFT_POINTS-1];
    reg [DATA_WIDTH-1:0] twiddle_factors [0:FFT_POINTS/2-1];

    always @(posedge clk) begin
        if (rst) begin
            done <= 0;
        end else if (start) begin
            // Initialize temporary data array
            for (int i = 0; i < FFT_POINTS; i++) begin
                temp_data[i] <= data_in;
            end
            // Perform FFT
            for (int i = 0; i < FFT_POINTS/2; i++) begin
                for (int j = 0; j < FFT_POINTS/2; j++) begin
                    temp_data[2*i+j] <= temp_data[2*i+j] + temp_data[2*i+FFT_POINTS/2+j];
                    temp_data[2*i+j+FFT_POINTS/2] <= temp_data[2*i+j] - temp_data[2*i+FFT_POINTS/2+j];
                end
            end
            // Calculate twiddle factors
            for (int i = 0; i < FFT_POINTS/2; i++) begin
                twiddle_factors[i] <= $clog2(FFT_POINTS)? {1'b0, i} : {1'b1, i};
            end
            // Multiply and accumulate
            for (int i = 0; i < FFT_POINTS/2; i++) begin
                for (int j = 0; j < FFT_POINTS/2; j++) begin
                    temp_data[2*i+j] <= temp_data[2*i+j] * twiddle_factors[j];
                    temp_data[2*i+j+FFT_POINTS/2] <= temp_data[2*i+j+FFT_POINTS/2] * twiddle_factors[j];
                end
            end
            // Combine results
            for (int i = 0; i < FFT_POINTS; i++) begin
                data_out <= temp_data[i];
            end
            done <= 1;
        end
    end

endmodule