module param_subtractor_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] diff;
  wire borrow;

  param_subtractor dut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
  );

  initial begin
    $monitor("a=%h b=%h diff=%h borrow=%b", a, b, diff, borrow);
    a = 8'hFF;
    b = 8'h00;
    #10;
    a = 8'hAA;
    b = 8'h55;
    #10;
    a = 8'h00;
    b = 8'hFF;
    #10;
    a = 8'h01;
    b = 8'h01;
    #10;
    a = 8'h00;
    b = 8'h00;
    #10;
  end

endmodule