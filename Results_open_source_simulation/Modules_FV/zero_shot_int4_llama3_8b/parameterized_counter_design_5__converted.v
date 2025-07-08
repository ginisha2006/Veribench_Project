module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
logic [($clog2(MAX_COUNT+1)-1:0)] count;

param_counter dut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    count == 0);
always @(*) begin assert (@(posedge clk) disable iff (!rst && count < MAX_COUNT); end
    count == count + 1);
always @(*) begin assert (@(posedge clk) disable iff (!rst && count >= MAX_COUNT); end
    count == 0);
always @(*) begin assert (@(posedge clk) disable iff (!rst && count == 0); end
    count == 0);

endmodule