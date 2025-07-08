module tb_param_divider;

parameter WIDTH = 8;
reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) uut (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

initial begin
    // Test with valid inputs
    dividend = 16'd12; divisor = 16'd3;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: %b, Remainder: %b", dividend, divisor, quotient, remainder);
    
    // Test with invalid inputs (zero divisor)
    divisor = 16'd0;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: x, Remainder: x", dividend, divisor, quotient, remainder);
    
    // Test with invalid inputs (large dividend)
    dividend = 16'd256; divisor = 16'd4;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: %b, Remainder: %b", dividend, divisor, quotient, remainder);
    
    // Test with invalid inputs (small divisor)
    dividend = 16'd15; divisor = 16'd1;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: %b, Remainder: %b", dividend, divisor, quotient, remainder);
    
    // Test with boundary values
    dividend = 16'd255; divisor = 16'd1;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: %b, Remainder: %b", dividend, divisor, quotient, remainder);
    
    // Test with zero dividend
    dividend = 16'd0; divisor = 16'd5;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: x, Remainder: x", dividend, divisor, quotient, remainder);
    
    // Test with zero divisor and dividend
    dividend = 16'd0; divisor = 16'd0;
    #100;
    $monitor($time, "Dividend: %b, Divisor: %b, Quotient: x, Remainder: x", dividend, divisor, quotient, remainder);
    
    $finish;
end

endmodule