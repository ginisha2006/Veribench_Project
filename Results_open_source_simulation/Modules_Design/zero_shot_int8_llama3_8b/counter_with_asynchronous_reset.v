module counter(
    input wire clk,
    input wire reset,
    input wire ena,
    output reg [7:0] result
);

always @(posedge clk) begin
    if (reset) begin
        result <= 8'b00000000;
    end else if (ena) begin
        result <= result + 1;
    end
end

endmodule