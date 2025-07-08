module tb_param_adder;

parameter WIDTH = 8;

input [WIDTH-1:0] a, b;

output [WIDTH-1:0] sum;

output carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

property p_sum_correct;

@(posedge clk) disable iff (!rst_n)

($rose(carry) |=> ($onehot({a[WIDTH-1], b[WIDTH-1]}));

$display("Error: Carry set but no overflow");

endproperty

property p_sum_underflow;

@(posedge clk) disable iff (!rst_n)

(!$rose(carry) & $onehot({a[WIDTH-1], b[WIDTH-1]}));

$display("Error: Underflow detected");

endproperty

property p_sum_overflow;

@(posedge clk) disable iff (!rst_n)

($fell(carry) & $onehot({a[WIDTH-1], b[WIDTH-1]}));

$display("Error: Overflow detected");

endproperty

property p_sum_edge_cases;

@(posedge clk) disable iff (!rst_n)

(!a &&!b => sum == 0);

!(a == b => sum == a);

!(a == ~b => sum == ~a);

endproperty

property p_carry_edge_cases;

@(posedge clk) disable iff (!rst_n)

(!a &&!b => carry == 0);

!(a == b => carry == 0);

!(a == ~b => carry == 1);

endproperty

initial begin

#10 rst_n = 1'b0;

#20 rst_n = 1'b1;

#100 $finish;

end

endmodule