module tb_gray_count();

reg clk;
reg enable;
reg reset;

logic [7:0] gray_count;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

always @(*) begin assert (@(posedge reset) disable iff (!reset) ($onehot(gray_count))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ((gray_count == 0) | (gray_count == 255))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ($onehot(gray_count) && $onehot(gray_count - 1'b1))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) (gray_count == 255)); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) (gray_count == 0)); end

endmodule