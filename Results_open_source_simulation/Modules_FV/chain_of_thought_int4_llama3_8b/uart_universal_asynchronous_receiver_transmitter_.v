module tb_uart_module;
parameter BAUD_RATE = 9600;

logic clk;
logic rst;
logic rx;
logic tx;
logic [7:0] data_in;
logic [7:0] data_out;

uart_module uut (
   .clk(clk),
   .rst(rst),
   .rx(rx),
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst);
    ##[BAUD_RATE/2 - 1:1] p_clk_period;
endproperty

property p_rx_idle;
   !rx |=> ##[0:BAUD_RATE/2-1]!rx;
endproperty

property p_tx_idle;
   !tx |=> ##[0:BAUD_RATE/2-1]!tx;
endproperty

property p_data_in_valid;
    data_in == 8'b0 |=> ##[0:BAUD_RATE/2-1] data_in == 8'b0;
endproperty

property p_data_out_valid;
    data_out == 8'b0 |=> ##[0:BAUD_RATE/2-1] data_out == 8'b0;
endproperty

property p_rx_to_tx;
    rx && data_in!= 8'b0 |=> ##[0:BAUD_RATE/2-1] tx;
endproperty

property p_tx_to_rx;
    tx && data_out!= 8'b0 |=> ##[0:BAUD_RATE/2-1] rx;
endproperty

property p_baud_rate;
    repeat(10) (p_clk_period);
endproperty

assert property (p_clk_period);
assert property (p_rx_idle);
assert property (p_tx_idle);
assert property (p_data_in_valid);
assert property (p_data_out_valid);
assert property (p_rx_to_tx);
assert property (p_tx_to_rx);
assert property (p_baud_rate);

always @ (posedge clk) begin
    clk <= ~clk;
end

endmodule