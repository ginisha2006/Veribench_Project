module behav_counter(
    input wire clk,
    input wire [7:0] d,
    input wire load,
    input wire clear,
    output reg [7:0] cnt
);

always @(posedge clk) begin
    if (load)
        cnt <= d;
    else if (clear)
        cnt <= 8'b0;
    else
        cnt <= cnt + 1;
end

endmodule