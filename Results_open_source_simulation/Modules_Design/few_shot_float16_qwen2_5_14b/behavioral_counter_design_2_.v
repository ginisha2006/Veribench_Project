module behav_counter (
    input clk,
    input [7:0] d,
    input load,
    input clear,
    output reg [7:0] cnt
);
    always @(posedge clk) begin
        if (clear)
            cnt <= 0;
        else if (load)
            cnt <= d;
        else
            cnt <= cnt + 1;
    end
endmodule