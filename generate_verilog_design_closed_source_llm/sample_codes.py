half_adder_prompt = '''Generate a verilog HDL module for a half adder with inputs a, b and outputs sum, cout.
'''

half_adder_module = '''`timescale 1ns / 1ps
module half_adder (
    input a, b,
    output sum, cout
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule'''

param_adder_prompt = '''Generate a verilog HDL module for a parameterized N-bit adder with inputs a,b and output sum, cout.
'''

param_adder_module = '''
`timescale 1ns / 1ps
module param_adder #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH:0] sum,
    output cout // Extra bit for carry
);
    assign {{cout,sum}} = a + b;
endmodule
'''


