module counter(
    input clk,
    input reset,
    input ena,
    output [7:0] result
);

reg [7:0] count;

always @(posedge clk)
if (reset) begin
    count <= 8'b0;
end else if (ena) begin
    count <= count + 1;
end

assign result = count;

endmodule