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

uart_module #(.BAUD_RATE(9600)) dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk = ~clk;

property reset_assertion;
 @(posedge clk) disable iff (!rst) 
   tx == 1'b1 |-> ##[0:1] tx == 1'b1;
endproperty

assert property(reset_assertion);

property idle_state;
 @(posedge clk) disable iff (!rst) 
   tx == 1'b1 |=> ##[0:$] (tx !== 1'b0);
endproperty

assert property(idle_state);

property start_bit;
 @(posedge clk) disable iff (!rst) 
   tx === 1'b1 && ##1 rx === 1'b0 |-> ##1 tx === 1'b0;
endproperty

assert property(start_bit);

property stop_bit;
 @(posedge clk) disable iff (!rst) 
   tx === 1'b0 && ##8 tx === 1'b1 |-> ##1 tx === 1'b1;
endproperty

assert property(stop_bit);

property data_bits;
 @(posedge clk) disable iff (!rst) 
   tx === 1'b0 && ##1 {tx, tx, tx, tx, tx, tx, tx} inside {[8'h00 : 8'hFF]};
endproperty

assert property(data_bits);

property parity_bit;
 @(posedge clk) disable iff (!rst) 
   tx === 1'b0 && ##8 tx === 1'b0 && ##1 tx === 1'b1 |-> ##1 tx === 1'b1;
endproperty

assert property(parity_bit);

property valid_data_out;
 @(posedge clk) disable iff (!rst) 
   tx === 1'b0 && ##9 tx === 1'b1 |-> ##1 data_out matches 8'b????????;
endproperty

assert property(valid_data_out);

endmodule