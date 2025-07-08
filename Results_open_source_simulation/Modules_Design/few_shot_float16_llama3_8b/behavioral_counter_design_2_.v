module behav_counter (
    input clk,
    input [7:0] d,
    input load,
    input clear,
    output [7:0] cnt
);
    reg [7:0] temp;
    always @(posedge clk)
        if (clear) temp <= 0;
        else if (load) temp <= d;
        else temp <= temp + 1;
    assign cnt = temp;
endmodule