module param_divider_tb;

  reg [7:0] dividend;
  reg [7:0] divisor;
  wire [7:0] quotient;
  wire [7:0] remainder;

  param_divider #( .WIDTH(8) ) dut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  initial begin
    dividend = 8'h00;
    divisor = 8'h01;
    #10;
    dividend = 8'hFF;
    divisor = 8'h02;
    #10;
    dividend = 8'h00;
    divisor = 8'h00;
    #10;
    dividend = 8'hAA;
    divisor = 8'h55;
    #10;
    $finish;
  end

  always #5 begin
    $display("Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);
  end

endmodule