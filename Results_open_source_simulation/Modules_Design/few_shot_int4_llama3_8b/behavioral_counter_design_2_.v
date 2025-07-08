module behav_counter (
    input clk,
    input [7:0] d,
    input load,
    input clear,
    output [7:0] cnt
);
    reg [7:0] q;

    always @(posedge clk)
        if (clear)
            q <= 0;
        else if (load)
            q <= d;
        else
            q <= q + 1;

    assign cnt = q;
endmodule