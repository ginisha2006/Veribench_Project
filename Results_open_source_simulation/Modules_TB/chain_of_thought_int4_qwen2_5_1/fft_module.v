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
    rst <= 1; 
    start <= 0; 
    data_in <= 0;
    #5 rst <= 0;
end

always #5 clk = ~clk;

integer i;
initial begin
    @(negedge rst) begin
        @(posedge clk) start <= 1;
        @(posedge clk) data_in <= 12345;
        @(posedge clk) start <= 0;
        repeat (FFT_POINTS*2) @(posedge clk);
        if (done == 1) $display("Done asserted");
    end
end

initial begin
    $dumpfile("tb_fft_module.vcd");
    $dumpvars(0,tb_fft_module);
end