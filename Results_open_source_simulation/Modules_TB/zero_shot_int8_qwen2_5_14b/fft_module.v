module tb_fft_module;
    parameter DATA_WIDTH = 16;
    parameter FFT_POINTS = 1024;

    reg clk;
    reg rst;
    reg start;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    fft_module #(.DATA_WIDTH(DATA_WIDTH), .FFT_POINTS(FFT_POINTS)) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .data_out(data_out),
        .done(done)
    );

    initial begin
        clk <= 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst <= 1;
        start <= 0;
        data_in <= 0;
        #10;
        rst <= 0;
        #10;
        
        // Test case 1: Normal operation with valid data points
        start <= 1;
        data_in <= 8'hAA;
        #10;
        start <= 0;
        #((FFT_POINTS * 10) + 10); // Wait for processing all points
        
        // Test case 2: Start without any data input
        start <= 1;
        data_in <= 0;
        #10;
        start <= 0;
        #10;
        
        // Test case 3: Restart before completion
        start <= 1;
        data_in <= 8'hFF;
        #10;
        start <= 0;
        #5;
        start <= 1;
        data_in <= 8'h0F;
        #10;
        start <= 0;
        #((FFT_POINTS * 10) + 10);

        // Test case 4: Reset during operation
        start <= 1;
        data_in <= 8'hFE;
        #10;
        rst <= 1;
        #10;
        rst <= 0;
        #10;
        start <= 0;
        #10;

        // Test case 5: Edge case - maximum value input
        start <= 1;
        data_in <= {DATA_WIDTH{1'b1}};
        #10;
        start <= 0;
        #((FFT_POINTS * 10) + 10);

        // Test case 6: Edge case - minimum value input
        start <= 1;
        data_in <= {DATA_WIDTH{1'b0}};
        #10;
        start <= 0;
        #((FFT_POINTS * 10) + 10);

        $finish;
    end

    always @(posedge clk) begin
        if (!rst && done) begin
            $display("Data out: %h", data_out);
        end
    end
endmodule