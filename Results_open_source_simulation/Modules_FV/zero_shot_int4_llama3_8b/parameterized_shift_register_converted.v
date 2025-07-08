module tb_param_shift_reg;

parameter WIDTH = 8;

logic clk;
logic rst;
logic load;
logic [WIDTH-1:0] data_in;
logic [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out == data_in); end
always @(*) begin assert (@(posedge rst) data_out == 0); end
always @(*) begin assert (!load |-> data_out === data_out); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ($rose(load) |=> data_out == data_in); end
    @(posedge clk) disable iff (!rst) (!$rose(load) |=> data_out === data_out));

endmodule