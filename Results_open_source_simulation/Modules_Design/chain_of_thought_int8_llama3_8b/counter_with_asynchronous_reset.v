module counter(clk, reset, ena, result);

input wire clk;
input wire reset;
input wire ena;
output reg [7:0] result;

reg [7:0] count;

always @(posedge clk)
begin
    if (reset) begin
        count <= 8'd0;
    end else if (ena) begin
        count <= count + 1;
    end
end

assign result = count;

endmodule