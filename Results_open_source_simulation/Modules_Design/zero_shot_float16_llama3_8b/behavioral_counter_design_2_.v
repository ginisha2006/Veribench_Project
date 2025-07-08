module behav_counter(clk, d, load, clear, cnt);
reg [7:0] cnt_reg;
always @(posedge clk) begin
    if (load) cnt_reg <= 8'b0;
    else if (clear) cnt_reg <= 8'b0;
    else cnt_reg <= cnt_reg + 1;
end
assign cnt = cnt_reg;
endmodule