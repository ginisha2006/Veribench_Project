module tb_param_divider;

parameter WIDTH = 8;

reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) DUT (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

initial begin
    #100; // wait for clock cycle
    $monitor($time, "Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", 
             dividend, divisor, quotient, remainder);

    // Edge cases
    dividend <= 16'h0000; divisor <= 16'h0010; #100; $display("Expected quotient: 1, remainder: 6");
    dividend <= 16'h0000; divisor <= 16'h0001; #100; $display("Expected quotient: 0, remainder: 0");

    // Corner cases
    dividend <= 16'hFFFF; divisor <= 16'h0010; #100; $display("Expected quotient: 255, remainder: 5");
    dividend <= 16'h000F; divisor <= 16'h0003; #100; $display("Expected quotient: 3, remainder: 3");

    // Normal case
    dividend <= 16'h1234; divisor <= 16'h0123; #100; $display("Expected quotient: 1, remainder: 2");

    #100; $finish;
end

always #10 divisor <= ~divisor; // toggle divisor

endmodule