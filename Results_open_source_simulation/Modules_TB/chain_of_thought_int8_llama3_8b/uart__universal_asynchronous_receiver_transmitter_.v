Here is the Verilog testbench module:

uart_testbench;

parameter BAUD_RATE = 9600;

input clk;

input rst;

reg tx;

wire [7:0] data_in;

wire [7:0] data_out;

initial begin

#100 rst = 1'b1;

#10 rst = 1'b0;

repeat(100) begin

#10000000 clk = ~clk;

data_in = 8'h12;

#10000000 clk = ~clk;

$monitor($time, "tx: %b", tx);

$monitor($time, "data_out: %h", data_out);

end

end

always @(posedge clk) begin

if (~rst) begin

tx <= 1'bx;

end else begin

tx <= data_in[0];

end

end

assign data_out = {8{tx}};

endmodule