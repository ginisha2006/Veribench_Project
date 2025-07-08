module half_adder_tb;

  reg a;
  reg b;
  wire sum;
  wire carry;

  half_adder dut (a, b, sum, carry);

  initial begin
    $dumpfile("half_adder.vcd");
    $dumpvars(0, half_adder_tb);
    a = 0; b = 0; #5;
    a = 0; b = 1; #5;
    a = 1; b = 0; #5;
    a = 1; b = 1; #5;
    $finish;
  end

  always @(posedge clk) begin
    $monitor("a=%b b=%b sum=%b carry=%b", a, b, sum, carry);
  end

endmodule