timescale 1ns / 1ps
module uart_module #(parameter BAUD_RATE = 9600) (
    input clk,
    input rst,
    input rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);