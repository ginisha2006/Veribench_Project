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
    $dumpfile("param_multiplier_tb.vcd");
    $dumpvars(0, param_multiplier_tb);

    a = 8'h00;
    b = 8'h00;
    #10;
    a = 8'hFF;
    b = 8'hFF;
    #10;
    a = 8'hAA;
    b = 8'hBB;
    #10;
    a = 8'h01;
    b = 8'h02;
    #10;
    a = 8'h7F;
    b = 8'h80;
    #10;

    $finish;
  end

  always @(posedge clk) begin
    $monitor("a=%h b=%h product=%h", a, b, product);
  end

endmodule