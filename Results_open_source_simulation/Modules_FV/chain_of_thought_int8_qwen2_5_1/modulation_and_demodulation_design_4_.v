module tb_mod_demod (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] modulated_signal,
    output reg [15:0] demodulated_data
);

property p_clk;
 @(posedge clk) disable iff (!rst) 
    ##[0:$] data_in !== modulated_signal |-> ##1 demodulated_data == data_in;
endproperty

assert property(p_clk);

property p_reset;
 @(negedge rst) disable iff (!rst)
    modulated_signal == 16'h0000 & demodulated_data == 16'h0000;
endproperty

assert property(p_reset);

property p_edge_cases;
 @(posedge clk) disable iff (!rst)
    data_in === 16'hFFFF |-> ##1 modulated_signal === 16'h0000;
endproperty

assert property(p_edge_cases);

property p_corner_conditions;
 @(posedge clk) disable iff (!rst)
    data_in === 16'h0000 |-> ##1 modulated_signal === 16'hFFFF;
endproperty

assert property(p_corner_conditions);

property p_over_underflow;
 @(posedge clk) disable iff (!rst)
    data_in inside {[16'd1:16'd65534]} |-> ##1 modulated_signal inside {[16'd1:16'd65534]};
endproperty

assert property(p_over_underflow);

endmodule