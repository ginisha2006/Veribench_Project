module param_counter #(parameter MAX_COUNT = 255)(clk, rst, count);
reg [7:0] cnt;
always @(posedge clk)
if (rst) cnt <= 8'h0;
else if (cnt < MAX_COUNT) cnt <= cnt + 1'b1;
assign count = cnt;
endmodule