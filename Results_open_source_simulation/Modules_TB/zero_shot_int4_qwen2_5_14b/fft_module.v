module tb_fft_module;
    parameter DATA_WIDTH = 16;
    parameter FFT_POINTS = 1024;

    reg clk;
    reg rst;
    reg start;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    fft_module #(
        .DATA_WIDTH(DATA_WIDTH),
        .FFT_POINTS(FFT_POINTS)
    ) uut (
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
        rst <= 1; start <= 0; data_in <= 0;
        #10 rst <= 0;
        @(posedge clk) start <= 1;
        @(posedge clk) start <= 0;
        @(posedge clk) data_in <= 8'd1;
        @(posedge clk) data_in <= 8'd2;
        @(posedge clk) data_in <= 8'd3;
        @(posedge clk) data_in <= 8'd4;
        @(posedge clk) start <= 1;
        @(posedge clk) start <= 0;
        repeat (10*FFT_POINTS) @(posedge clk);
        $finish;
    end

    always @(posedge done) begin
        $display("Done signal asserted");
        if (data_out != 0) $display("Output data is %d", data_out);
    end

endmodule