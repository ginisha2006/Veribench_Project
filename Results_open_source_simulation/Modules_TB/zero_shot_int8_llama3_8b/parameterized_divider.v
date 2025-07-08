module param_divider_tb; 

parameter WIDTH = 8;

reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;

initial begin 
    #10; // delay for setup time
    dividend = 16'd12; // initial value for dividend
    divisor = 8'h4; // initial value for divisor
    #20; // delay for clock cycle
    $monitor($time, "Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);

    #100; // delay for multiple cycles
    dividend = 16'd25; // new value for dividend
    divisor = 8'h5; // new value for divisor
    #20; // delay for clock cycle
    $monitor($time, "Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);

    #100; // delay for multiple cycles
    divisor = 8'h0; // zero divisor case
    #20; // delay for clock cycle
    $monitor($time, "Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);

    #100; // delay for multiple cycles
    dividend = 16'd255; // maximum value for dividend
    divisor = 8'hc; // maximum value for divisor
    #20; // delay for clock cycle
    $monitor($time, "Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);

    #100; // delay for multiple cycles
    $finish; // end of simulation
end

always #10; // clock pulse
dividend = dividend + 1; // increment dividend

endmodule