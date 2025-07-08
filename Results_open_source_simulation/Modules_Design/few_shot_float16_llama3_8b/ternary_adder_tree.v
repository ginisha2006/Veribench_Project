timescale 1ns / 1ps
module ternary_adder_tree #(parameter WIDTH=16) (
    input [WIDTH-1:0] A, B, C, D, E,
    input CLK,
    output [WIDTH-1:0] OUT
);