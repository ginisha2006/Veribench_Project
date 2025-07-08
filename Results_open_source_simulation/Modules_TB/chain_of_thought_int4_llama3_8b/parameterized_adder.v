timescale 1ns / 100ps;

module tb_param_adder;

parameter WIDTH = 8;
reg [WIDTH-1:0] a, b;
wire [WIDTH-1:0] sum;
wire carry;

param_adder #(.WIDTH(WIDTH)) uut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

initial begin
    // Initialize inputs
    a = 0; b = 0;
    #10;

    // Test with small numbers
    a = 1; b = 2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with large numbers
    a = 127; b = 128;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with overflow
    a = 255; b = 1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with underflow
    a = -128; b = -129;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with all zeros
    a = 0; b = 0;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with one zero and one non-zero
    a = 0; b = 1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with two non-zeros
    a = 1; b = 2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with negative numbers
    a = -1; b = -2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with mixed sign numbers
    a = -1; b = 2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with very large numbers
    a = 254; b = 2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with very small numbers
    a = -254; b = -2;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with edge cases (e.g., a = 0, b = 1, a = 1, b = 0)
    a = 0; b = 1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    a = 1; b = 0;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with corner cases (e.g., a = 0, b = 0, a = 1, b = 1)
    a = 0; b = 0;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    a = 1; b = 1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with extreme values
    a = 255; b = 255;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    a = -256; b = -256;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with invalid inputs (e.g., a = 256, b = 1)
    a = 256; b = 1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    a = -257; b = -1;
    #20;
    $display("Sum: %h, Carry: %b", sum, carry);

    // Test with multiple cycles
    repeat(5) begin
        a = 1; b = 2;
        #20;
        $display("Sum: %h, Carry: %b", sum, carry);
    end

    // Test with different clock phases
    for (int i = 0; i < 5; i++) begin
        a = 1; b = 2;
        #20;
        $display("Sum: %h, Carry: %b", sum, carry);
        #10;
    end

    // Test with