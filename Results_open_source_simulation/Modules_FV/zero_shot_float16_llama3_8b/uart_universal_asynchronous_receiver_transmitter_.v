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
    @(posedge clk) disable iff (!rst) ($rose(clk) |=> ##[BAUD_RATE*10 - 1 : 0] $fell(clk));
endproperty

property p_data_in_range;
    @(posedge clk) disable iff (!rst) ((data_in < 8'h00) | (data_in > 8'hff));
endproperty

property p_data_out_range;
    @(posedge clk) disable iff (!rst) ((data_out < 8'h00) | (data_out > 8'hff));
endproperty

property p_tx_idle_low;
    @(posedge clk) disable iff (!rst) (!rst |-> tx == 1'b0);
endproperty

property p_rx_idle_high;
    @(posedge clk) disable iff (!rst) (!rst |->!rx);
endproperty

property p_data_transmission;
    @(posedge clk) disable iff (!rst) ((data_in!= 8'h00) |->
        ##[BAUD_RATE*10 : 0] tx && ##[BAUD_RATE*10 : 0]!tx);
endproperty

property p_data_reception;
    @(posedge clk) disable iff (!rst) ((data_in!= 8'h00) |->
        ##[BAUD_RATE*10 : 0] rx && ##[BAUD_RATE*10 : 0]!rx);
endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst) ((data_in!= 8'h00) |->
        ##[BAUD_RATE*10 : 0] (data_in == 8'hff) | ##[BAUD_RATE*10 : 0] (data_in == 8'00));
endproperty

assert property (p_clk_period);
assert property (p_data_in_range);
assert property (p_data_out_range);
assert property (p_tx_idle_low);
assert property (p_rx_idle_high);
assert property (p_data_transmission);
assert property (p_data_reception);
assert property (p_overflow_underflow);

always
    #5 clk = ~clk; // clock generation

initial
    rst = 1'b1;
    #10 rst = 1'b0;

endmodule