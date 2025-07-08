module param_adder_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] sum;
  wire carry;

  param_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial begin
    $monitor("a=%h b=%h sum=%h carry=%b", a, b, sum, carry);
    a = 8'd0;
    b = 8'd0;
    #10;
    a = 8'd127;
    b = 8'd127;
    #10;
    a = 8'd255;
    b = 8'd0;
    #10;
    a = 8'd0;
    b = 8'd255;
    #10;
    a = 8'd128;
    b = 8'd128;
    #10;
    $finish;
  end

endmodule