module tb_uart_module;

parameter BAUD_RATE = 9600;
parameter CLOCK_PERIOD = 10000000; // Assuming 10 MHz clock

logic clk;
logic rst;
logic rx;
logic tx;
logic [7:0] data_in;
logic [7:0] data_out;

uart_module dut (
   .clk(clk),
   .rst(rst),
   .rx(rx),
   .tx(tx),
   .data_in(data_in),
   .data_out(data_out)
);

property p_clk_period;
    @(posedge clk) disable iff (!rst);
    ##1;
    @(negedge clk) disable iff (!rst);
    ##1;
endproperty

property p_rx_idle;
   !rx |=>!data_out[0];
endproperty

property p_tx_idle;
   !tx |=>!data_out[0];
endproperty

property p_data_in_valid;
    data_in!= 8'h0 |=> data_out == data_in;
endproperty

property p_data_out_valid;
    data_out!= 8'h0 |=> data_in == data_out;
endproperty

property p_overflow;
    $rose(data_in) |=> $fell(data_out);
endproperty

property p_underflow;
    $fell(data_in) |=> $rose(data_out);
endproperty

assert property (p_clk_period);
assert property (p_rx_idle);
assert property (p_tx_idle);
assert property (p_data_in_valid);
assert property (p_data_out_valid);
assert property (p_overflow);
assert property (p_underflow);

always
    #((CLOCK_PERIOD / 2) - 1) clk = ~clk;
    #((CLOCK_PERIOD / 2)) clk = clk;

endmodule