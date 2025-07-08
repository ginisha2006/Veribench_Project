timescale 1ns / 1ps
module param_counter #(parameter MAX_COUNT = 255) (
    input clk,
    input rst,
    output reg [7:0] count
);
    always @(posedge clk)
        if (rst) count <= 0;
        else if (count < MAX_COUNT) count <= count + 1'b1;