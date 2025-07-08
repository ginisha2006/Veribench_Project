module tb_param_subtractor;
 parameter WIDTH = 8;

 reg [WIDTH-1:0] a;
 reg [WIDTH-1:0] b;
 wire [WIDTH-1:0] diff;
 wire borrow;

 param_subtractor #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
 );

 initial begin
    // Initialize inputs
    a = 0; b = 0;
    #10;
    $monitor("At time %t, a=%d, b=%d, diff=%d, borrow=%d", $time, a, b, diff, borrow);

    // Test case 1: Both inputs zero
    a = 0; b = 0;
    #10;

    // Test case 2: Normal subtraction (positive result)
    a = 5; b = 3;
    #10;

    // Test case 3: Borrow case (negative result)
    a = 3; b = 5;
    #10;

    // Test case 4: Maximum value for 'a' with 'b' as zero
    a = 255; b = 0;
    #10;

    // Test case 5: Maximum value for 'b' with 'a' less than 'b'
    a = 127; b = 255;
    #10;

    // Test case 6: Edge case where both values are maximum
    a = 255; b = 255;
    #10;

    // Test case 7: Minimum value for 'a' with 'b' as zero
    a = 0; b = 0;
    #10;

    // Test case 8: Random values
    a = 123; b = 45;
    #10;

    // Finish simulation
    $finish;
 end

endmodule