module param_comparator_tb;

  reg [7:0] A;
  reg [7:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  initial begin
    $monitor("A=%b B=%b Equal=%b Greater=%b Less=%b", A, B, Equal, Greater, Less);
    A = 8'h00; B = 8'h00; #10;
    A = 8'hFF; B = 8'hFF; #10;
    A = 8'h01; B = 8'h00; #10;
    A = 8'h00; B = 8'h01; #10;
    A = 8'hAA; B = 8'hBB; #10;
    A = 8'hBB; B = 8'hAA; #10;
    A = 8'h00; B = 8'hFF; #10;
    A = 8'hFF; B = 8'h00; #10;
    $finish;
  end

endmodule