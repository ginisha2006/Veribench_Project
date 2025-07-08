timescale 1ns / 1ps
module fibonacci_gen #(parameter WIDTH=8) (
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output [WIDTH-1:0] fib
);