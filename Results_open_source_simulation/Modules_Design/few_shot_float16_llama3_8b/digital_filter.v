timescale 1ns / 1ps
module digital_filter #(parameter DATA_WIDTH=16, parameter COEFF_WIDTH=16, parameter NUM_TAPS=32) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out,
    input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);