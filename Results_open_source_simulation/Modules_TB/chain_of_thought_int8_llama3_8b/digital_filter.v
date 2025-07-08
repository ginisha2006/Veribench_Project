module digital_filter_tb;

parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

initial begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
    #100 $display("Reset done");
end

always #5 clk = ~clk;

digital_filter dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .data_out(data_out),
   .coeff(coeff)
);

integer i;
initial begin
    for (i=0; i<NUM_TAPS; i=i+1) begin
        coeff[i] = $random();
    end
    data_in = 16'h1234;
    #100 $monitor($time, "data_in: %h", data_in);
    #100 $monitor($time, "data_out: %h", data_out);
    #500 $finish;
end

endmodule