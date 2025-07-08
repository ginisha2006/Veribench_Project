module tb_full_adder;

  reg a;
  reg b;
  reg cin;
  wire sum;
  wire cout;

  full_adder dut (a, b, cin, sum, cout);

  property p_sum;
    a == 0 && b == 0 && cin == 0 -> sum == 0;
    a == 0 && b == 0 && cin == 1 -> sum == 1;
    a == 0 && b == 1 && cin == 0 -> sum == 1;
    a == 0 && b == 1 && cin == 1 -> sum == 2;
    a == 1 && b == 0 && cin == 0 -> sum == 1;
    a == 1 && b == 0 && cin == 1 -> sum == 2;
    a == 1 && b == 1 && cin == 0 -> sum == 0;
    a == 1 && b == 1 && cin == 1 -> sum == 1;
  endproperty

  property p_cout;
    a == 0 && b == 0 && cin == 0 -> cout == 0;
    a == 0 && b == 0 && cin == 1 -> cout == 1;
    a == 0 && b == 1 && cin == 0 -> cout == 1;
    a == 0 && b == 1 && cin == 1 -> cout == 1;
    a == 1 && b == 0 && cin == 0 -> cout == 1;
    a == 1 && b == 0 && cin == 1 -> cout == 1;
    a == 1 && b == 1 && cin == 0 -> cout == 1;
    a == 1 && b == 1 && cin == 1 -> cout == 1;
  endproperty

  assert property (p_sum);
  assert property (p_cout);

endmodule