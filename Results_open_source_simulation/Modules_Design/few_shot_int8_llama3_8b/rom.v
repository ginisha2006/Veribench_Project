timescale 1ns / 1ps
module rom_simple #(parameter DATA_WIDTH=8, ADDR_WIDTH=8) (
    input [ADDR_WIDTH-1:0] addr,
    output [DATA_WIDTH-1:0] data_out
);