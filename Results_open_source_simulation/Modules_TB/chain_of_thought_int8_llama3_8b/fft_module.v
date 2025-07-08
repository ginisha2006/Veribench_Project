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
    #10 clk = 1'b0; rst = 1'b1; start = 1'b0;
    #20 rst = 1'b0;
    #100 start = 1'b1;
    #200 start = 1'b0;
    #500 $stop;
end

always #5 clk = ~clk;

assign data_in = 16'h1234;

fft_module uut (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

$monitor($time, "clk=%b, rst=%b, start=%b, data_in=0x%x, data_out=0x%x, done=%b", clk, rst, start, data_in, data_out, done);

endmodule