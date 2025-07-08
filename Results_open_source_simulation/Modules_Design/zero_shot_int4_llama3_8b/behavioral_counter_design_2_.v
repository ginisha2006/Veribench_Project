module behav_counter;
input [7:0] d;
input clk, load, clear;
output reg [7:0] cnt;

always @(posedge clk) begin
    if (load)
        cnt <= d;
    else if (clear)
        cnt <= 8'b0;
    else
        cnt <= cnt + 1;
end
endmodule