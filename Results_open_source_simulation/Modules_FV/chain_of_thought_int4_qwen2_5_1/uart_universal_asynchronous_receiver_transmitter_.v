module tb_uart_module (
    input clk,
    input rst,
    input rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);

property reset_assertion;
    @(posedge rst) disable iff (!rst)
        !tx;
endproperty
assert property(reset_assertion);

property tx_inactive_on_reset;
    @(posedge rst) disable iff (!rst)
        tx == 0;
endproperty
assert property(tx_inactive_on_reset);

property rx_stable_when_rst_high;
    @(posedge rst) disable iff (!rst)
        !$isunknown(rx);
endproperty
assert property(rx_stable_when_rst_high);

property data_in_stable_when_rst_high;
    @(posedge rst) disable iff (!rst)
        !$isunknown(data_in);
endproperty
assert property(data_in_stable_when_rst_high);

property data_out_stable_when_rst_high;
    @(posedge rst) disable iff (!rst)
        !$isunknown(data_out);
endproperty
assert property(data_out_stable_when_rst_high);

property tx_not_driven_if_rx_is_idle;
    @(posedge clk) disable iff (!rst)
        !rx |=> !tx;
endproperty
assert property(tx_not_driven_if_rx_is_idle);

property data_out_valid_after_tx_active;
    @(posedge clk) disable iff (!rst)
        tx ##[1:8] data_out != 8'bZ;
endproperty
assert property(data_out_valid_after_tx_active);

property data_out_matches_data_in;
    @(posedge clk) disable iff (!rst)
        tx ##[1:8] data_out == data_in;
endproperty
assert property(data_out_matches_data_in);

property no_overlapping_transmissions;
    @(posedge clk) disable iff (!rst)
        !($rose(tx)) |-> ##[1:$] !($fell(tx));
endproperty
assert property(no_overlapping_transmissions);

endmodule