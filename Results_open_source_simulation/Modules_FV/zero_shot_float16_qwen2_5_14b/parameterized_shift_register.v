module tb_param_shift_reg(
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

wire clk_wire;
reg rst_wire;
reg load_wire;
reg [7:0] data_in_wire;

assign clk_wire = clk;
assign rst_wire = rst;
assign load_wire = load;
assign data_in_wire = data_in;

param_shift_reg #(.WIDTH(8)) dut (
    .clk(clk_wire),
    .rst(rst_wire),
    .load(load_wire),
    .data_in(data_in_wire),
    .data_out(data_out)
);

always #5 clk_wire = ~clk_wire;

property reset_assertion;
    @(posedge clk_wire) disable iff (!rst_wire)
    (rst_wire && !load_wire) |-> ##[1:2] data_out == 8'b0;
endproperty

assert property(reset_assertion);

property load_data;
    @(posedge clk_wire) disable iff (!rst_wire)
    (load_wire && !rst_wire) |-> ##1 data_out == data_in_wire;
endproperty

assert property(load_data);

endmodule