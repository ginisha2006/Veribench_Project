module tb_gray_count;

logic clk, enable, reset;
logic [7:0] gray_count;

reg [7:0] q;
reg [7:0] no_ones_below;
reg q_msb;

always @(*) begin assert (@(posedge reset) disable iff (!reset) ($onehot(q))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ((q == 0) => (q[-1] == 1))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ((q[i] == q[i-1] ^ (no_ones_below[i-1])) for (i=1 to 7))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) (q_msb == (q[7] | q[6]))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) (gray_count == q)); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) (~$onehot(gray_count))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ($onehot(gray_count))); end
always @(*) begin assert (@(posedge clk) disable iff (!enable) ((q!= 0) && (q[-1] == 1))); end

endmodule