module tb_uart_module (
    input clk,
    input rst,
    input rx,
    output reg tx,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;
wire rst;
wire rx;
reg [7:0] data_in;
wire [7:0] data_out;

uart_module #(
    .BAUD_RATE(9600)
) dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk = ~clk;

property reset_assertion;
    @(posedge rst) disable iff (!rst)
        !tx;
endproperty

assert property(reset_assertion);

property rx_inactive_high;
    @(posedge clk) disable iff (!rst)
        !rx |-> !tx;
endproperty

assert property(rx_inactive_high);

property tx_active_on_data;
    @(posedge clk) disable iff (!rst)
        data_in != 8'b0 & rx == 1 => ##[1:10] tx == 1;
endproperty

assert property(tx_active_on_data);

property tx_inactive_after_transmit;
    @(posedge clk) disable iff (!rst)
        data_in != 8'b0 & rx == 1 & ##[1:10] tx == 1 => ##[1:10] tx == 0;
endproperty

assert property(tx_inactive_after_transmit);

property data_out_stable;
    @(posedge clk) disable iff (!rst)
        data_in != 8'b0 & rx == 1 & ##[1:10] tx == 1 => ##[1:10] data_out != 8'bZ;
endproperty

assert property(data_out_stable);

property data_out_reset;
    @(posedge rst) disable iff (!rst)
        data_out == 8'b0;
endproperty

assert property(data_out_reset);

endmodule