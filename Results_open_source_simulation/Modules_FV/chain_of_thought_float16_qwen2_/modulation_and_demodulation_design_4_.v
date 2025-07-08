module tb_mod_demod (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] modulated_signal,
    output reg [15:0] demodulated_data
);

mod_demod #(.DATA_WIDTH(16)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
);

reg clk;
always #5 clk = ~clk;

property p_clk;
 @(posedge clk) disable iff (!rst) ##[0:$] !($isunknown(data_in));
endproperty
assert property(p_clk);

property p_reset;
 @(negedge rst) disable iff (!rst) demodulated_data == 16'h0000;
endproperty
assert property(p_reset);

property p_modulate;
 @(posedge clk) disable iff (!rst) modulated_signal == data_in ^ 16'hFFFF;
endproperty
assert property(p_modulate);

property p_demodulate;
 @(posedge clk) disable iff (!rst) demodulated_data == modulated_signal ^ 16'hFFFF;
endproperty
assert property(p_demodulate);

property p_consistency;
 @(posedge clk) disable iff (!rst) demodulated_data == data_in;
endproperty
assert property(p_consistency);

endmodule