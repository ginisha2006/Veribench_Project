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
    repeat (100) begin
        #5 clk = ~clk;
    end
    #10 rst = 1'b0;
    #20 start = 1'b1;
    #50 start = 1'b0;
end

always @(posedge clk)
begin
    if (rst) begin
        data_in <= 'b0;
    end else if (start &&!done) begin
        data_in <= $random();
    end
end

assign data_out = fft_module_inst.data_out;
assign done = fft_module_inst.done;

fft_module fft_module_inst (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
);

$monitor($time, "clk=%b, rst=%b, start=%b, data_in=%h, data_out=%h, done=%b", clk, rst, start, data_in, data_out, done);

initial begin
    $display("Simulation started");
    #1000000 $finish;
end

endmodule