module tb_param_shift_reg;

parameter WIDTH = 8;

input clk;
input rst;
input load;
input [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst); end
   !data_out[WIDTH-1:0]);
always @(*) begin assert (@(posedge clk) disable iff (!load &&!rst); end
    data_out == data_in);
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    ($onehot {data_out[WIDTH-1:0]}));
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    data_out[WIDTH-1] == data_in[WIDTH-1]);
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    data_out[0] == data_in[0]);

endmodule