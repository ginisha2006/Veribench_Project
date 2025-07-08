module param_multiplier_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [15:0] product;

  param_multiplier dut (
    .a(a),
    .b(b),
    .product(product)
  );

  initial begin
    $monitor("a=%h b=%h product=%h", a, b, product);
    a = 8'd0;
    b = 8'd0;
    #10;
    a = 8'd1;
    b = 8'd2;
    #10;
    a = 8'd3;
    b = 8'd4;
    #10;
    a = 8'd5;
    b = 8'd6;
    #10;
    a = 8'd7;
    b = 8'd8;
    #10;
    a = 8'd15;
    b = 8'd15;
    #10;
    $finish;
  end

endmodule