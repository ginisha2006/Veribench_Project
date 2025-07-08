module tb_uart_module (
    input clk,
    input rst,
    input rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);

wire internal_clk;
reg clk_gen;

uart_module uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
);

always begin
    #(5ns) clk_gen = ~clk_gen;
end

assign internal_clk = clk_gen;

assert (@(posedge internal_clk) disable iff (!rst) 
        data_out == 8'b0);

assert (@(posedge internal_clk) disable iff (!rst)
        !rx |=> ##[1:10] tx !== 1'b1);

assert (@(posedge internal_clk) disable iff (!rst)
        $rose(rx) |-> ##[10:100] data_out != 8'b0);

assert (@(posedge internal_clk) disable iff (!rst)
        !$isunknown(data_in) |-> !$isunknown(data_out));

assert (@(posedge internal_clk) disable iff (!rst)
        !($past(rx)) && rx && ($past(!tx)) && tx);

endmodule