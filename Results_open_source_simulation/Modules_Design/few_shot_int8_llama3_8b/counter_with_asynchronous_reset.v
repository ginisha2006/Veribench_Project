module counter (
    input clk, reset, ena,
    output reg [7:0] result
);
    always @(posedge clk)
        if (reset) begin
            result <= 0;
        end else if (ena) begin
            result <= result + 1'b1;
        end
endmodule