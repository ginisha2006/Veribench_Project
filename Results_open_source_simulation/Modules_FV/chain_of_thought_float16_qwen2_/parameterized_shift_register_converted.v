module tb_param_shift_reg (
    input clk,
    input rst,
    input load,
    input [7:0] data_in,
    output reg [7:0] data_out
);

wire clk_wire;
assign clk_wire = clk;

always @(*) begin assert (@(posedge clk_wire) disable iff (!rst) data_out == 0); end

always @(*) begin assert (@(posedge clk_wire) disable iff (!load | rst) data_out == data_in); end

always @(*) begin assert (@(posedge clk_wire) disable iff (load | rst) data_out !== data_in); end

always @(*) begin assert (@(posedge clk_wire) disable iff (!rst) (data_out == 0) |-> (load | rst)); end

always @(*) begin assert (@(posedge clk_wire) disable iff (!load | rst) ($past(data_out != data_in))); end

always @(*) begin assert (@(posedge clk_wire) disable iff (load | rst) data_out inside {[0:255]}); end

endmodule