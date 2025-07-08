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
        // Initialize values
        dividend = 4'b0000; divisor = 4'b0001; #10; $monitor("dividend=%b, divisor=%b, quotient=%b, remainder=%b", dividend, divisor, quotient, remainder);
        dividend = 4'b0001; divisor = 4'b0001; #10; $monitor("dividend=%b, divisor=%b, quotient=%b, remainder=%b", dividend, divisor, quotient, remainder);
        dividend = 4'b1111; divisor = 4'b0010; #10; $monitor("dividend=%b, divisor=%b, quotient=%b, remainder=%b", dividend, divisor, quotient, remainder);
        dividend = 4'b1111; divisor = 4'b1111; #10; $monitor("dividend=%b, divisor=%b, quotient=%b, remainder=%b", dividend, divisor, quotient, remainder);
        dividend = 4'b1000; divisor = 4'b0000; #10; $monitor("dividend=%b, divisor=%b, quotient=%b, remainder=%b", dividend, divisor, quotient, remainder);
        #50 $finish;
    end
endmodule