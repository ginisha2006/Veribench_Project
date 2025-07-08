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
        forever #(5) clk <= ~clk; // Clock period is 10 time units
    end

    initial begin
        rst <= 1;
        start <= 0;
        data_in <= 0;
        #(20) rst <= 0;
        #(10) start <= 1;
        data_in <= 12'd789;
        #(10) start <= 0;
        #(10) start <= 1;
        data_in <= 12'd123;
        #(10) start <= 0;
        #(10) start <= 1;
        data_in <= 12'hABCD >> (16 - DATA_WIDTH);
        #(10) start <= 0;
        #(10) start <= 1;
        data_in <= 12'hEFGH >> (16 - DATA_WIDTH);
        #(10) start <= 0;
        #(10) $finish;
    end

    always @(posedge clk) begin
        if (!rst && done) begin
            $display("Data Out: %d", data_out);
        end
    end
endmodule