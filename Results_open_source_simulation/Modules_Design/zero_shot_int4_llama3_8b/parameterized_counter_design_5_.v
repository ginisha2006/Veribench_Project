module param_counter #(parameter MAX_COUNT = 255)(clk, rst, count);
reg [7:0] cnt;
always @(posedge clk) begin
    if (rst) cnt <= 8'b0;
    else cnt <= cnt + 1;
end
assign count = cnt;
endmodule