module counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
always @(posedge clk or posedge reset)
begin
    if (reset)
        result <= 8'b0;
    else if (ena)
        result <= result + 1;
end
endmodule