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
    // Initialize inputs
    dividend = 16'd12;
    divisor = 16'd3;

    #100; // Wait for some time before starting the simulation

    // Test with valid inputs
    $display("Testing with valid inputs:");
    $monitor($time, "Dividend: %b", dividend);
    $monitor($time, "Divisor: %b", divisor);
    #100;
    $display("Quotient: %b", quotient);
    $display("Remainder: %b", remainder);

    // Test with invalid inputs (zero divisor)
    divisor = 16'd0;
    #100;
    $display("Testing with zero divisor:");
    $monitor($time, "Dividend: %b", dividend);
    $monitor($time, "Divisor: %b", divisor);
    #100;
    $display("Quotient: %b", quotient);
    $display("Remainder: %b", remainder);

    // Test with invalid inputs (large dividend)
    dividend = 16'd10000000;
    #100;
    $display("Testing with large dividend:");
    $monitor($time, "Dividend: %b", dividend);
    $monitor($time, "Divisor: %b", divisor);
    #100;
    $display("Quotient: %b", quotient);
    $display("Remainder: %b", remainder);

    // Test with invalid inputs (large divisor)
    divisor = 16'd10000000;
    #100;
    $display("Testing with large divisor:");
    $monitor($time, "Dividend: %b", dividend);
    $monitor($time, "Divisor: %b", divisor);
    #100;
    $display("Quotient: %b", quotient);
    $display("Remainder: %b", remainder);

    // Stop the simulation after all tests have been run
    #1000;
    $finish;
end

endmodule