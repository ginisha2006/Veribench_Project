timescale 1ns / 1ps
module ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we,
    input read_clock, write_clock,
    output [7:0] q
);