Here is the Verilog testbench module:

uart_tb;

parameter BAUD_RATE = 9600;

reg clk;

reg rst;

wire tx;

wire [7:0] data_in;

wire [7:0] data_out;

initial begin

#100 clk = 1'b1;

forever #(BAUD_RATE/8) clk = ~clk;

rst = 1'b1;

#10 rst = 1'b0;

data_in = 8'h12;

repeat(5) begin

#10000;

$display("Sending byte: %h", data_in);

tx = 1'b1;

#500 tx = 1'b0;

#10000;

tx = 1'b1;

#500 tx = 1'b0;

end

#1000000 $finish;

end

always @(posedge clk) begin

if (~rst) begin

data_out <= 8'bx;

end else begin

data_out <= data_in;

end

end

initial begin

$monitor($time," clk:%b, rst:%b, rx:%b, tx:%b, data_in:%h, data_out:%h\n",

clk, rst, rx, tx, data_in, data_out);

end