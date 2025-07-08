module tb_gray_count;

logic clk, enable, reset;
logic [7:0] gray_count;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

always @(*) begin assert (@(posedge reset) disable iff (!reset) gray_count == 8'h00); end
assert (@(posedge clk) disable iff (!enable) gray_count === gray_count;
@(posedge clk) disable iff (enable) gray_count!= gray_count);
always @(*) begin assert (@(posedge clk) disable iff (!reset) ($onehot(gray_count))); end
always @(*) begin assert (@(posedge clk) disable iff (reset) gray_count >= 8'hff || gray_count < 8'h00); end
assert (@(posedge clk) disable iff (reset) gray_count!== gray_count;
@(posedge clk) disable iff (enable) gray_count!== gray_count);

endmodule