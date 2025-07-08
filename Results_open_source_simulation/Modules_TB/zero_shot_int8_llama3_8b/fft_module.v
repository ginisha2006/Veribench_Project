module fft_tb;

parameter DATA_WIDTH = 16;
parameter FFT_POINTS = 1024;

reg clk;
reg rst;
reg start;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire done;

initial begin
    clk = 0;
    rst = 1;
    start = 0;
    #10 rst = 0;
    #20 start = 1;
    #100 start = 0;
    #200 $finish;
end

always #5 clk = ~clk;

fft_module uut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

integer i;
initial begin
    for (i = 0; i < FFT_POINTS; i++) begin
        data_in = $random % (1 << DATA_WIDTH) - (1 << (DATA_WIDTH-1));
        @(posedge clk);
    end
end

$monitor($time, "clk=%b rst=%b start=%b data_in=0x%x done=%b", clk, rst, start, data_in, done);

endmodule