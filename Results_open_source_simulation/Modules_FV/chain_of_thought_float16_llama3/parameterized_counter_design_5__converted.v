module tb_param_counter;

parameter MAX_COUNT = 255;

logic clk;
logic rst;
reg [$clog2(MAX_COUNT+1)-1:0] count;

param_counter #(MAX_COUNT) dut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

always @(*) begin assert (@(posedge clk) disable iff (!rst) count == 0); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == $past(count)))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == MAX_COUNT && $past(count) < MAX_COUNT) |-> (count == 0)); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == 0 && $past(count) > 0) |-> (count == 0)); end

endmodule