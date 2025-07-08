module tb_gray_count;

reg clk;
reg enable;
reg reset;

gray_count dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count()
);

always @(*) begin assert (@(posedge clk) disable iff (!reset); end
    $(gray_count == 8'h00));
always @(*) begin assert (@(posedge clk) disable iff (!enable); end
    $(|gray_count[7:0]) == 1'b1);
always @(*) begin assert (@(posedge clk) disable iff (enable); end
    $(|gray_count[7:0]) == 1'b0);
always @(*) begin assert (@(posedge clk) disable iff (!reset &&!enable); end
    $(gray_count[7:0] >= 8'h80));
always @(*) begin assert (@(posedge clk) disable iff (!reset &&!enable); end
    $(gray_count[7:0] < 8'h00));

endmodule