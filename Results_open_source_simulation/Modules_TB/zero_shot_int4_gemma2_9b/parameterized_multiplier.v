module param_multiplier_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [15:0] product;

  param_multiplier #( .WIDTH(8) ) dut (
    .a(a),
    .b(b),
    .product(product)
  );

  initial begin
    $monitor("a=%h b=%h product=%h", a, b, product);
    a = 0; b = 0; #10;
    a = 1; b = 1; #10;
    a = 7; b = 7; #10;
    a = 8'hFF; b = 8'hFF; #10;
    a = 8'h00; b = 8'hFF; #10;
    a = 8'hFF; b = 8'h00; #10;
    $finish;
  end

endmodule