Here is the SystemVerilog testbench code for the parameterized multiplier:

tb_param_multiplier.sv

module tb_param_multiplier;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .product(product)
);

