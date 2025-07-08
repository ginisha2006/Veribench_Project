module tb_mod_demod #(parameter DATA_WIDTH = 16) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] modulated_signal,
    output [DATA_WIDTH-1:0] demodulated_data
);

logic clk;
logic rst;

mod_demod dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

property p_clk_posedge;
    @(posedge clk) disable iff (!rst) property (@(posedge clk)!rst; endproperty

property p_reset_assertion;
    @(negedge rst) disable iff (!rst) property (!rst); endproperty

property p_modulation_correctness;
    @(posedge clk) disable iff (!rst) property ($onehot(data_in) && modulated_signal == (^data_in << 1)); endproperty

property p_demodulation_correctness;
    @(posedge clk) disable iff (!rst) property ($onehot(modulated_signal) && demodulated_data == (^modulated_signal << 1)); endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst) property (~($signed(data_in) >= 0) | ~($signed(demodulated_data) >= 0)); endproperty

assert property (p_clk_posedge);
assert property (p_reset_assertion);
assert property (p_modulation_correctness);
assert property (p_demodulation_correctness);
assert property (p_overflow_underflow);

endmodule