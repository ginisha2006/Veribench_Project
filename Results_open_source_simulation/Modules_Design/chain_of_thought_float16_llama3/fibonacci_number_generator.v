module fibonacci_gen #(parameter WIDTH = 8) (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);