timescale 1ns / 1ps
module param_counter #(parameter MAX_COUNT=255) (
    input clk, rst,
    output reg [7:0] count
);