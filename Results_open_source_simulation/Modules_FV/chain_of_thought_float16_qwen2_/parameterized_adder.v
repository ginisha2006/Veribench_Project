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
    clk = 1'b0; #5;
    clk = 1'b1; #5;
end

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
        ($rose(carry)) |-> (sum == (a + b)[WIDTH-1:0]);
endproperty

assert property(p_no_overflow_underflow);

property p_carry_behavior;
    @(posedge clk) disable iff (!reset)
        (a[WIDTH-1] & b[WIDTH-1]) |-> carry === (a + b)[WIDTH];
endproperty

assert property(p_carry_behavior);

property p_sum_correctness;
    @(posedge clk) disable iff (!reset)
        sum === (a + b)[WIDTH-1:0];
endproperty

assert property(p_sum_correctness);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
        ((a == 'd0 && b == 'd0) || (a == 'd0 && b == 'd1) ||
         (a == 'd1 && b == 'd0) || (a == 'd1 && b == 'd1))
            |-> (carry === (a + b)[WIDTH] && sum === (a + b)[WIDTH-1:0]);
endproperty

assert property(p_edge_cases);

property p_all_zeros;
    @(posedge clk) disable iff (!reset)
        (a == 'd0 && b == 'd0) |-> (carry === 'd0 && sum == 'd0);
endproperty

assert property(p_all_zeros);

property p_max_values;
    @(posedge clk) disable iff (!reset)
        (a == 'd((1 << WIDTH)-1) && b == 'd((1 << WIDTH)-1))
            |-> (carry === 'd1 && sum == 'd((1 << (WIDTH-1))-1));
endproperty

assert property(p_max_values);

endmodule