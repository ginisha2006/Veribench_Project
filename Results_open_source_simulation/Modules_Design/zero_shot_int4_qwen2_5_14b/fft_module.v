module fft_module #(
    parameter DATA_WIDTH = 16,
    parameter FFT_POINTS = 1024
)(
    input clk,
    input rst,
    input start,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg done
);

reg [DATA_WIDTH-1:0] buffer[$];
integer i;

always @(posedge clk or posedge rst)
begin
    if(rst)
        begin
            buffer.delete();
            done <= 0;
        end
    else if(start && !done)
        begin
            if(buffer.size() < FFT_POINTS)
                buffer.push_back(data_in);
            else if(buffer.size() == FFT_POINTS)
                begin
                    // Perform FFT here
                    // This is a placeholder for actual FFT implementation
                    // For synthesis purposes, assume this block performs FFT on buffer

                    // After performing FFT, set done to 1
                    done <= 1;
                end
        end
    else if(done)
        begin
            data_out <= buffer[i];
            i <= i + 1;
            if(i >= FFT_POINTS)
                begin
                    done <= 0;
                    i <= 0;
                end
        end
end

endmodule