timescale 1ns / 1ps
module seven_seg_display #(parameter DATA_WIDTH=4) (
    input [DATA_WIDTH-1:0] data,
    output reg [6:0] seg
);