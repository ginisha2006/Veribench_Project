timescale 1ns / 1ps
module reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);