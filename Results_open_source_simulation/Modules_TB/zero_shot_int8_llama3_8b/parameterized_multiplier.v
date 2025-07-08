module tb_param_multiplier;

parameter WIDTH = 4; // Change this value to test different widths

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) DUT (.a(a),.b(b),.product(product));

initial begin
    $monitor($time, $bits(a), $bits(b), $bits(product));
    
    #100; // Wait for 100 time units
    
    a <= 3'b0001; // Test with small values
    b <= 3'b0011;
    #10;
    
    a <= 3'b1111; // Test with large values
    b <= 3'b1111;
    #10;
    
    a <= 3'b1010; // Test with mixed sign bits
    b <= 3'b0101;
    #10;
    
    a <= 3'b0000; // Test with zero inputs
    b <= 3'b0000;
    #10;
    
    a <= 3'b1111; // Test with overflow condition
    b <= 16'd10000; // Overflow occurs when a is 16'd15 and b is 16'd256
    #10;
    
    $finish;
end

endmodule