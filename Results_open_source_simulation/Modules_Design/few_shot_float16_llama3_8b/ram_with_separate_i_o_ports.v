timescale 1ns / 1ps
module ram_separate_io #(parameter DATA_WIDTH=8, ADDR_WIDTH=8) (
    input clk,
    input we,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);