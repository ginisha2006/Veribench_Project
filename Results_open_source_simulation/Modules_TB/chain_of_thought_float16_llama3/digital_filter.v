Here is the Verilog testbench module:

digital_filter_tb;

parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

initial begin
    #10 clk = 1'b0;
    forever #(5) clk = ~clk;
end

initial begin
    rst = 1'b1;
    #20 rst = 1'b0;
end

integer i;
initial begin
    for (i=0; i<NUM_TAPS; i=i+1) begin
        coeff[i] = $random();
    end
    data_in = 16'h1234;
    @(posedge clk);
    $monitor($time, "rst=%b, data_in=%h, coeff=%p, data_out=%h", rst, data_in, coeff, data_out);
    repeat (100) begin
        data_in = {data_in[15:8], $random()};
        @(posedge clk);
        $monitor($time, "rst=%b, data_in=%h, coeff=%p, data_out=%h", rst, data_in, coeff, data_out);
    end
end

endmodule