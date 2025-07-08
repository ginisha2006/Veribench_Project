module behav_counter (
    input clk,
    input [7:0] d,
    input load,
    input clear,
    output [7:0] cnt
);
    reg [7:0] count;
    always @(posedge clk)
        if (clear)
            count <= 0;
        else if (load)
            count <= d;
        else
            count <= count + 1;
    assign cnt = count;
endmodule