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
    a = 8'hFF;
    b = 8'hAA;
    #10;
    a = 8'h00;
    b = 8'hFF;
    #10;
    a = 8'h7F;
    b = 8'h7F;
    #10;
    a = 8'h01;
    b = 8'h01;
    #10;
    $finish;
  end

endmodule