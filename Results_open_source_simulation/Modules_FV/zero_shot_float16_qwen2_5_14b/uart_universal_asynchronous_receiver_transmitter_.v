module tb_uart_module (
    input clk,
    input rst,
    input rx,
    output reg tx,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;
wire rx;
reg [7:0] data_in;
wire [7:0] data_out;

uart_module uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk =~clk;

property reset_assertion;
 @(posedge clk) disable iff (!rst) 
   tx == 1'b0;
endproperty

assert property(reset_assertion);

property rx_transmit;
 @(posedge clk) disable iff (!rst)
   ##[1:$] (rx == 1'b1 && data_in != 8'hFF) |-> ##1 tx == 1'b1;
endproperty

assert property(rx_transmit);

property transmit_data;
 @(posedge clk) disable iff (!rst)
   ##[1:$] (rx == 1'b0 && data_in != 8'hFF) |-> ##32 tx == 1'b0;
endproperty

assert property(transmit_data);

property receive_data;
 @(posedge clk) disable iff (!rst)
   ##[1:$] (rx == 1'b1 && data_in != 8'hFF) |-> ##4 data_out !== 8'hFF;
endproperty

assert property(receive_data);

property idle_state;
 @(posedge clk) disable iff (!rst)
   ##[1:$] (rx == 1'b0 && data_in == 8'hFF) |-> ##1 tx == 1'b0;
endproperty

assert property(idle_state);

property transition_check;
 @(posedge clk) disable iff (!rst)
   ##[1:$] (rx ##1 !rx) |-> ##1 tx === !tx;
endproperty

assert property(transition_check);

endmodule