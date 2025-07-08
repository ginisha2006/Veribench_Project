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

property p_positive_edge_rst;
 @(posedge clk) disable iff (!rst)
 !rst |-> ##[0:$] rst;
endproperty
assert property(p_positive_edge_rst);

property p_modulation_correctness;
 @(posedge clk) disable iff (!rst)
 modulated_signal == data_in ^ {16{1'b1}};
endproperty
assert property(p_modulation_correctness);

property p_demodulation_correctness;
 @(posedge clk) disable iff (!rst)
 demodulated_data == modulated_signal ^ {16{1'b1}};
endproperty
assert property(p_demodulation_correctness);

endmodule