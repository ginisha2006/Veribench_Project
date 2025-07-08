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
 @(posedge clk) disable iff (!rst)
 !rst |-> ##[0:$] modulated_signal == data_in ^ {16{1'b1}};
endproperty
assert property(p_clk);

property p_rst;
 @(posedge rst) disable iff (!rst)
 rst |-> (modulated_signal == 16'hFFFF & demodulated_data == 16'hFFFF);
endproperty
assert property(p_rst);

property p_demod;
 @(posedge clk) disable iff (!rst)
 !rst |-> demodulated_data == data_in;
endproperty
assert property(p_demod);

endmodule