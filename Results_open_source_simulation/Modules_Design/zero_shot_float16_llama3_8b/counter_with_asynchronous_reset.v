module counter(clk, reset, ena, result);
reg [7:0] count;
always @(posedge clk) begin
    if (reset) count <= 8'b0;
    else if (ena) count <= count + 1;
end
assign result = count;
endmodule