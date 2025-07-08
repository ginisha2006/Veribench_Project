module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
logic [($clog2(MAX_COUNT+1)-1:0)] count_exp;
logic [($clog2(MAX_COUNT+1)-1:0)] count_act;

param_counter dut (
   .clk(clk),
   .rst(rst),
   .count(count_act)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    count == 0);
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    count <= count + 1 |-> count == count + 1);
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    count >= MAX_COUNT |=> count == 0);
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    count == MAX_COUNT |=> count == 0);

endmodule