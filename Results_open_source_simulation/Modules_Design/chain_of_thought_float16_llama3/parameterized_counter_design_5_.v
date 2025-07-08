module param_counter #(parameter MAX_COUNT = 255)(clk, rst, count);
reg [7:0] count_reg;
always @(posedge clk)
if (rst) count_reg <= 8'h00;
else if (count_reg < MAX_COUNT) count_reg <= count_reg + 1'b1;
assign count = count_reg;
endmodule