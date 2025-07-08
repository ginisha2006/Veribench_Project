module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
logic [($clog2(MAX_COUNT+1)-1:0)] count;

param_counter #(MAX_COUNT) dut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst) count == 0); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == count[($clog2(MAX_COUNT+1)-1]:0) + 1))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == MAX_COUNT && nexttime(count == 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == 0 && nexttime(count!= 0))); end
always @(*) begin assert (@(posedge clk) disable iff (rst) count == 0); end

always #10 clk = ~clk;

endmodule