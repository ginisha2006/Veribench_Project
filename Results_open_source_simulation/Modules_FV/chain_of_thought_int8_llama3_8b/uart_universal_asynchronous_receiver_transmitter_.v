module tb_uart_module;

parameter BAUD_RATE = 9600;

input clk;

input rst;

input rx;

output tx;

input [7:0] data_in;

output [7:0] data_out;

uart_module uut (.clk(clk),.rst(rst),.rx(rx),.tx(tx),.data_in(data_in),.data_out(data_out));

property p_rx_idle;
    @(posedge clk) disable iff (!rst) rx == 1'b0;
endproperty

property p_tx_idle;
    @(posedge clk) disable iff (!rst) tx == 1'b0;
endproperty

property p_data_in_valid;
    @(posedge clk) disable iff (!rst) data_in!= 8'h00;
endproperty

property p_data_out_valid;
    @(posedge clk) disable iff (!rst) data_out!= 8'h00;
endproperty

property p_rx_to_tx;
    @(posedge clk) disable iff (!rst) ($fell(rx) => tx == data_in);
endproperty

property p_tx_to_rx;
    @(posedge clk) disable iff (!rst) ($rose(tx) => rx == 1'b1);
endproperty

property p_baud_rate;
    @(posedge clk) disable iff (!rst) ($countones(clk) % (BAUD_RATE * 10) == 0);
endproperty

assert property (p_rx_idle);
assert property (p_tx_idle);
assert property (p_data_in_valid);
assert property (p_data_out_valid);
assert property (p_rx_to_tx);
assert property (p_tx_to_rx);
assert property (p_baud_rate);

endmodule