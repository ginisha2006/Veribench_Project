module tb_param_multiplier(
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] clk,
    output [15:0] product
);

reg [7:0] a_int;
reg [7:0] b_int;

param_multiplier #(.WIDTH(8)) dut (
    .a(a),
    .b(b),
    .product(product)
);

always begin
    clk = 0; #5;
    clk = 1; #5;
end

property p_clk;
  @(posedge clk) disable iff (!clk) (a !== a[int']) |-> ##[1:$] (a == a[int']);
endproperty
assert property(p_clk);

property p_product_correctness;
  @(posedge clk) disable iff (!clk) (a * b === product);
endproperty
assert property(p_product_correctness);

property p_edge_cases;
  @(posedge clk) disable iff (!clk) ((a == 8'b0 && b != 8'b0) |-> (product == 8'b0))
      and ((a != 8'b0 && b == 8'b0) |-> (product == 8'b0));
endproperty
assert property(p_edge_cases);

property p_overflow_underflow;
  @(posedge clk) disable iff (!clk) ((a > 8'hFF / b || b > 8'hFF / a) && (a != 8'b0 && b != 8'b0)) |-> (product != a * b);
endproperty
assert property(p_overflow_underflow);

endmodule