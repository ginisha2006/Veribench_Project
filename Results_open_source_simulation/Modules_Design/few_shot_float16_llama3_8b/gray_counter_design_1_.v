timescale 1ns / 1ps
module gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);