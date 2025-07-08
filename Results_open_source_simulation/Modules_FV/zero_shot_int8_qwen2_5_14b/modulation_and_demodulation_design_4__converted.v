module tb_mod_demod (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] modulated_signal,
    output reg [15:0] demodulated_data
);

reg clk;
wire rst;
wire [15:0] data_in;
wire [15:0] modulated_signal;
wire [15:0] demodulated_data;

mod_demod #(.DATA_WIDTH(16)) uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
);

always #5 clk =~clk;

assert (@(posedge clk) disable iff (!rst) 
   data_in !== modulated_signal |-> ##1 demodulated_data == data_in);

assert (@(negedge rst) disable iff (!rst)
   modulated_signal == 16'hFFFF & demodulated_data == 16'hFFFF);

assert (@(posedge clk) disable iff (!rst)
   data_in === 16'h0000 |-> ##1 demodulated_data == 16'h0000;
   data_in === 16'hFFFF |-> ##1 demodulated_data == 16'hFFFF);

endmodule