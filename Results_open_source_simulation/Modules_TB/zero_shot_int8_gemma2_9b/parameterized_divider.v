module param_divider_tb #(
  parameter WIDTH = 8
);

  reg [WIDTH-1:0] dividend;
  reg [WIDTH-1:0] divisor;
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

  param_divider #(WIDTH) dut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  initial begin
    $monitor("Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);
    dividend = 8'd1234; divisor = 8'd5; #10;
    dividend = 8'd0; divisor = 8'd7; #10;
    dividend = 8'd255; divisor = 8'd1; #10;
    dividend = 8'd1; divisor = 8'd1; #10;
    $finish;
  end

endmodule