module tb_uart_module;

parameter BAUD_RATE = 9600;
reg clk;
reg rst;
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;

uart_module uut (
   .clk(clk),
   .rst(rst),
   .rx(1'b0), // assume RX is always idle
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst) ($onehotzero(clk));
endproperty

property p_data_in_width;
    @(posedge clk) disable iff (!rst) ((|data_in) && ($size(data_in) == 8));
endproperty

property p_tx_idle;
    @(posedge clk) disable iff (!rst) (!tx ||!rx);
endproperty

property p_rx_idle;
    @(posedge clk) disable iff (!rst) (!rx ||!tx);
endproperty

property p_data_out_width;
    @(posedge clk) disable iff (!rst) ((|data_out) && ($size(data_out) == 8));
endproperty

property p_uart_transmit;
    @(posedge clk) disable iff (!rst) ((data_in!= 8'h00) -> tx);
endproperty

property p_uart_receive;
    @(posedge clk) disable iff (!rst) ((rx) -> (data_out!= 8'hzzz));
endproperty

assert property (p_clk_period);
assert property (p_data_in_width);
assert property (p_tx_idle);
assert property (p_rx_idle);
assert property (p_data_out_width);
assert property (p_uart_transmit);
assert property (p_uart_receive);

always #10 clk = ~clk; // generate clock

initial begin
    rst = 1'b1;
    #20 rst = 1'b0;
end

endmodule