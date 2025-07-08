module tb_uart_module (
    input clk,
    input rst,
    input rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);

property p_clk;
 @(posedge clk) !rst |=> ##[1:$] clk;
endproperty
assert property(p_clk);

property p_rst;
 @(posedge clk) rst |-> (tx == 1'b0 && data_out == 8'b0);
endproperty
assert property(p_rst);

property p_tx_idle;
 @(posedge clk) disable iff(rst) !data_in[0] |=> ##[5:10] tx === 1'b0;
endproperty
assert property(p_tx_idle);

property p_rx_data_valid;
 @(posedge clk) disable iff(rst) rx === 1'b1 |=> ##[5:10] data_out !== 8'b0;
endproperty
assert property(p_rx_data_valid);

property p_data_sync;
 @(posedge clk) disable iff(rst) data_in !== 8'b0[*4] |=> ##[5:10] data_out !== 8'b0;
endproperty
assert property(p_data_sync);

property p_over_underflow;
 @(posedge clk) disable iff(rst) !$isunknown(data_in) |-> !(data_out < 8'b0 || data_out > 8'hFF);
endproperty
assert property(p_over_underflow);

property p_illegal_transition;
 @(posedge clk) disable iff(rst) !($past(rx)) && rx |=> !($past(tx)) && tx;
endproperty
assert property(p_illegal_transition);

endmodule