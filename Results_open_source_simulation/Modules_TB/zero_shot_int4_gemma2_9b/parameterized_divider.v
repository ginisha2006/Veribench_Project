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
    dividend = 8'd100;
    divisor = 8'd10;
    #10;
    dividend = 8'd255;
    divisor = 8'd3;
    #10;
    dividend = 8'd0;
    divisor = 8'd7;
    #10;
    dividend = 8'd128;
    divisor = 8'd1;
    #10;
    $finish;
  end

  always @(posedge clk) begin
    $monitor("Dividend: %h, Divisor: %h, Quotient: %h, Remainder: %h", dividend, divisor, quotient, remainder);
  end

endmodule