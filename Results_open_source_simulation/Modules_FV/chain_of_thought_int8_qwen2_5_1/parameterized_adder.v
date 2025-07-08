module tb_param_adder #(
    parameter WIDTH = 8
)(
);

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

logic clk;
always begin
    clk = 1; #5; clk = 0; #5;
end

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    ($rose(carry) |-> (a[WIDTH-1] === b[WIDTH-1]))
        and
    (~$rose(carry) |-> (sum == a + b));
endproperty
assert property(p_no_overflow_underflow);

property p_sum_correctness;
    @(posedge clk) disable iff (!reset)
    (sum == a + b);
endproperty
assert property(p_sum_correctness);

property p_carry_behavior;
    @(posedge clk) disable iff (!reset)
    (carry === (a[WIDTH-1] & b[WIDTH-1]) |
     (a[WIDTH-1] & sum[WIDTH-2]) |
     (b[WIDTH-1] & sum[WIDTH-2]));
endproperty
assert property(p_carry_behavior);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    ((a == 'hFFFF && b == 'hFFFF) |-> carry === 1'b1)
        and
    ((a == 'h0 && b == 'h0) |-> carry === 1'b0);
endproperty
assert property(p_edge_cases);

endmodule