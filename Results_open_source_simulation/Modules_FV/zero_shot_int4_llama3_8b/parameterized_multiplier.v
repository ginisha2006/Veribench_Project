Here is the SystemVerilog testbench code for the parameterized multiplier:

tb_param_multiplier.sv

module tb_param_multiplier;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .product(product)
);

property p_product_calculation;
    @(posedge clk) disable iff (!rst_n);
    a == b[0]? a * b : 0;
endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst_n);
    ($onehot product[W-1:0] && product[W+WIDTH-1:W]) |-> (a[W-1:0] > W'd31 || b[W-1:0] > W'd31);
endproperty

property p_zero_result;
    @(posedge clk) disable iff (!rst_n);
    a == 0 |=> product == 0;
endproperty

property p_nonzero_result;
    @(posedge clk) disable iff (!rst_n);
    a!= 0 & b!= 0 |=> product!= 0;
endproperty

property p_multiply_by_zero;
    @(posedge clk) disable iff (!rst_n);
    b == 0 |=> product == 0;
endproperty

property p_multiply_by_one;
    @(posedge clk) disable iff (!rst_n);
    b == 1 |=> product == a;
endproperty

property p_multiply_by_minus_one;
    @(posedge clk) disable iff (!rst_n);
    b == -1 |=> product == -a;
endproperty

property p_multiply_by_two;
    @(posedge clk) disable iff (!rst_n);
    b == 2 |=> product == a << 1;
endproperty

property p_multiply_by_negative_two;
    @(posedge clk) disable iff (!rst_n);
    b == -2 |=> product == -a << 1;
endproperty

property p_multiply_by_three;
    @(posedge clk) disable iff (!rst_n);
    b == 3 |=> product == a << 1 + a;
endproperty

property p_multiply_by_negative_three;
    @(posedge clk) disable iff (!rst_n);
    b == -3 |=> product == -(a << 1 + a);
endproperty

property p_multiply_by_four;
    @(posedge clk) disable iff (!rst_n);
    b == 4 |=> product == a << 2;
endproperty

property p_multiply_by_negative_four;
    @(posedge clk) disable iff (!rst_n);
    b == -4 |=> product == -a << 2;
endproperty

property p_multiply_by_five;
    @(posedge clk) disable iff (!rst_n);
    b == 5 |=> product == a << 2 + a;
endproperty

property p_multiply_by_negative_five;
    @(posedge clk) disable iff (!rst_n);
    b == -5 |=> product == -(a << 2 + a);
endproperty

property p_multiply_by_six;
    @(posedge clk) disable iff (!rst_n);
    b == 6 |=> product == a << 2 + a + a;
endproperty

property p_multiply_by_negative_six;
    @(posedge clk) disable iff (!rst_n);
    b == -6 |=> product == -(a << 2 + a + a);
endproperty

property p_multiply_by_seven;
    @(posedge clk) disable iff (!rst_n);
    b == 7 |=> product == a << 2 + a + a + a;
endproperty

property p_multiply_by_negative_seven;
    @(posedge clk) disable iff (!rst_n);
    b == -7 |=> product == -(a << 2 + a + a + a);
endproperty

property p_multiply_by_eight;
    @(posedge clk) disable iff (!rst_n);
    b == 8 |=> product == a << 3;
endproperty

property p_multiply_by_negative_eight;
    @(posedge clk) disable iff (!rst_n);
    b == -8 |=> product == -a << 3;
endproperty

property p_multiply_by_nine;
    @(posedge clk) disable iff (!rst_n);
    b == 9 |=> product == a << 3 + a;
endproperty

property p_multiply_by_negative_nine;
    @(posedge clk) disable iff (!rst_n);
    b == -9 |=> product == -(a << 3 + a);
endproperty

property p_multiply_by_ten;
    @(posedge clk) disable iff (!rst_n);
    b == 10 |=> product == a << 3 + a + a;
endproperty