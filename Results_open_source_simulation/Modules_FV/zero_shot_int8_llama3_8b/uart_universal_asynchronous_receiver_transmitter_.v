module tb_uart_module;

parameter BAUD_RATE = 9600;
reg clk;
reg rst;
wire tx;
wire [7:0] data_in;
wire [7:0] data_out;

uart_module dut (
   .clk(clk),
   .rst(rst),
   .rx(1'b0), // stub for RX input
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst) dist <= 10000000 / BAUD_RATE; // 10ms period at 9600 baud rate
endproperty

property p_data_in_range;
   !(data_in > 8'hff || data_in < 8'h00); // data_in should be within range [0, 255]
endproperty

property p_tx_output;
    @(posedge clk) disable iff (!rst) tx == 1'b0; // default tx output is low
endproperty

property p_data_out_match;
    @(posedge clk) disable iff (!rst) data_out === data_in; // data_out should match data_in
endproperty

property p_rx_idle;
    @(posedge clk) disable iff (!rst) rx == 1'b0; // RX line should be idle when not transmitting
endproperty

property p_rx_edge;
    @(posedge clk) disable iff (!rst) rx == 1'b1; // RX line should transition high on rising edge of clk
endproperty

property p_rx_low;
    @(posedge clk) disable iff (!rst) rx == 1'b0; // RX line should stay low after falling edge of clk
endproperty

property p_underflow;
    @(posedge clk) disable iff (!rst) ($rose(data_in) && data_out!== data_in); // underflow condition
endproperty

property p_overflow;
    @(posedge clk) disable iff (!rst) ($fell(data_in) && data_out!== data_in); // overflow condition
endproperty

assert property (p_clk_period);
assert property (p_data_in_range);
assert property (p_tx_output);
assert property (p_data_out_match);
assert property (p_rx_idle);
assert property (p_rx_edge);
assert property (p_rx_low);
assert property (p_underflow);
assert property (p_overflow);

always begin
    #10 clk = ~clk; // toggle clock every 10ns
end

initial begin
    rst = 1'b1;
    #20 rst = 1'b0; // deassert reset after 20 cycles
end

endmodule