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
        divisor = 0;
        #10;
        
        // Test case 3: Edge case - maximum value
        dividend = {WIDTH{1'b1}}; divisor = 1;
        #10;
        
        // Test case 4: Edge case - minimum value
        dividend = 0; divisor = {WIDTH{1'b1}};
        #10;
        
        // Test case 5: Random values
        dividend = $random; divisor = $random & {{WIDTH-1{1'b0}}, 1'b1}; // Ensure non-zero divisor
        #10;
        
        // Final check
        $finish;
    end
    
    always @(posedge $anyseq) begin
        $monitor("Cycle: %d | Dividend: %b (%d) | Divisor: %b (%d) | Quotient: %b (%d) | Remainder: %b (%d)", $time, dividend, dividend, divisor, divisor, quotient, quotient, remainder, remainder);
    end
endmodule