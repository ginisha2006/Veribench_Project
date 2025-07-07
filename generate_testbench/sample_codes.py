half_adder_prompt = '''module half_adder(
    input a,
    input b,
    output sum,
    output carry
);
assign sum = a ^ b;
assign carry = a & b;
endmodule '''

half_adder_tb = '''`timescale 1ns / 1ps
module tb_half_adder;
// Inputs
reg a;
reg b;
// Outputs
wire sum;
wire carry;
// Instantiate the Half Adder
half_adder uut (
    .a(a), 
    .b(b), 
    .sum(sum), 
    .carry(carry)
);
initial begin
    // Display the header for the output
    $display("Time\ta\tb\tsum\tcarry");
    // Monitor changes to inputs and outputs
    $monitor("%0d\t%b\t%b\t%b\t%b", $time, a, b, sum, carry);
    // Test all possible input combinations
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule'''

param_adder_prompt = '''module param_adder #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum,
    output carry
);
assign {carry, sum} = a + b;
endmodule'''

param_adder_tb = '''
`timescale 1ns / 1ps
module tb_param_adder;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Outputs
wire [WIDTH-1:0] sum;
wire carry;
// Instantiate the Parameterized Adder
param_adder #(.WIDTH(WIDTH)) uut (
    .a(a), 
    .b(b), 
    .sum(sum), 
    .carry(carry)
);
initial begin
    // Display the header for the output
    $display("Time\ta\t\tb\t\tsum\t\tcarry");
    // Monitor changes to inputs and outputs
    $monitor("%0d\t%b\t%b\t%b\t%b", $time, a, b, sum, carry);
    // Test Case 1: Add zero + zero
    a = 0; b = 0; #10;    
    // Test Case 2: Add zero + one
    a = 0; b = 1; #10;
    // Test Case 3: Add one + one
    a = 1; b = 1; #10;
    // Test Case 4: Add max + zero
    a = {WIDTH{1'b1}}; b = 0; #10;
    // Test Case 5: Add max + one
    a = {WIDTH{1'b1}}; b = 1; #10;
    // Test Case 6: Add max + max
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    // Test Case 7: Add mid-value + mid-value
    a = {WIDTH{1'b0}} | (1 << (WIDTH/2)); b = {WIDTH{1'b0}} | (1 << (WIDTH/2)); #10;
    // Finish the simulation
    $finish;
end
endmodule
'''


