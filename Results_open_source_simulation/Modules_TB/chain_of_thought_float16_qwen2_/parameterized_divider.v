module tb_param_divider;
    parameter WIDTH = 8;
    reg [WIDTH-1:0] dividend;
    reg [WIDTH-1:0] divisor;
    wire [WIDTH-1:0] quotient;
    wire [WIDTH-1:0] remainder;

    initial begin
        #10 dividend = 4'b0000; divisor = 4'b0001; // Division by one
        #10 dividend = 4'b1111; divisor = 4'b0010; // Division with remainder
        #10 dividend = 4'b1000; divisor = 4'b1000; // Exact division
        #10 dividend = 4'b0001; divisor = 4'b1000; // Small number divided by larger number
        #10 dividend = 4'b1111; divisor = 4'b1111; // Division by self
        #10 dividend = 4'b0000; divisor = 4'b0000; // Division by zero (should be handled externally)
        #10 $finish;
    end

    always @(dividend, divisor) begin
        $display("Dividend: %b, Divisor: %b, Quotient: %b, Remainder: %b", dividend, divisor, quotient, remainder);
    end

    param_divider #(WIDTH) uut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder)
    );
endmodule