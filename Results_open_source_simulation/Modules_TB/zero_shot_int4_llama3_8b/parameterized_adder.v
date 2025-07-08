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

    // Test with small values
    a = 2; b = 3;
    #20;
    $display("Expected sum: %h, actual sum: %h", 5, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b0, carry);

    // Test with large values
    a = 127; b = 128;
    #20;
    $display("Expected sum: %h, actual sum: %h", 255, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b1, carry);

    // Test with overflow
    a = 255; b = 1;
    #20;
    $display("Expected sum: %h, actual sum: %h", 0, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b1, carry);

    // Test with negative numbers (assuming two's complement representation)
    a = -128; b = -129;
    #20;
    $display("Expected sum: %h, actual sum: %h", -257, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b1, carry);

    // Test with all zeros
    a = 0; b = 0;
    #20;
    $display("Expected sum: %h, actual sum: %h", 0, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b0, carry);

    // Test with all ones
    a = 255; b = 255;
    #20;
    $display("Expected sum: %h, actual sum: %h", 510, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b1, carry);

    // Test with mixed sign numbers (assuming two's complement representation)
    a = -128; b = 127;
    #20;
    $display("Expected sum: %h, actual sum: %h", -1, sum);
    $display("Expected carry: %b, actual carry: %b", 1'b0, carry);

    $finish;
end

always @(posedge uut.carry) begin
    $display("Carry changed!");
    $stop;
end

endmodule