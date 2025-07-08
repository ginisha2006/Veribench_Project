module half_adder_tb;

  reg a;
  reg b;
  wire sum;
  wire carry;
  half_adder dut (a, b, sum, carry);

  initial begin
    $monitor("a=%b b=%b sum=%b carry=%b", a, b, sum, carry);
    a = 0; b = 0; #5;
    a = 0; b = 1; #5;
    a = 1; b = 0; #5;
    a = 1; b = 1; #5;
  end

endmodule