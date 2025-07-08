module full_adder_tb();

  reg a;
  reg b;
  reg cin;
  wire sum;
  wire cout;

  full_adder dut (a, b, cin, sum, cout);

  initial begin
    $monitor("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 1; #10;
  end

endmodule