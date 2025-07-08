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
        // Initialize signals
        dividend = 0; divisor = 1;
        #10;
        
        // Test case 1: Normal division
        dividend = 15; divisor = 3;
        #10;
        
        // Test case 2: Division with zero divisor
        dividend = 10; divisor = 0;
        #10;
        
        // Test case 3: Edge case - maximum value
        dividend = (1 << WIDTH) - 1; divisor = 1;
        #10;
        
        // Test case 4: Edge case - minimum non-zero divisor
        dividend = (1 << WIDTH) - 1; divisor = 2;
        #10;
        
        // Test case 5: Random values
        dividend = $random; divisor = $random;
        #10;
        
        // Test case 6: Zero dividend
        dividend = 0; divisor = 5;
        #10;
        
        // Test case 7: Divisor larger than dividend
        dividend = 5; divisor = 10;
        #10;
        
        // Monitor outputs
        $monitor($time, " ns | dividend=%d, divisor=%d, quotient=%d, remainder=%d", dividend, divisor, quotient, remainder);
    end
    
endmodule