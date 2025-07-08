module tb_fft_module;
    parameter DATA_WIDTH = 16;
    parameter FFT_POINTS = 1024;

    reg clk;
    reg rst;
    reg start;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    fft_module #(.DATA_WIDTH(DATA_WIDTH), .FFT_POINTS(FFT_POINTS)) uut (
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
        #10
        rst <= 0;
        #10
        start <= 1;
        data_in <= 10'd1;
        #20
        data_in <= 10'd2;
        #20
        data_in <= 10'd3;
        #20
        start <= 0;
        #10
        start <= 1;
        data_in <= 10'd4;
        #20
        data_in <= 10'd5;
        #20
        data_in <= 10'd6;
        #20
        start <= 0;
        #10
        $finish;
    end

    initial begin
        $dumpfile("fft_tb.vcd");
        $dumpvars(0, tb_fft_module);
    end

    always @(posedge clk) begin
        if (done == 1) begin
            $display("Data Out: %d", data_out);
        end
    end
endmodule