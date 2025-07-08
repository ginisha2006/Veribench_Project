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

assert (@(posedge clk) disable iff (!reset)
    ($rose(carry) |-> (a[WIDTH-1] === b[WIDTH-1]))
        and
    (~$rose(carry) |-> (sum == a + b)));

assert (@(posedge clk) disable iff (!reset)
    (sum == a + b));

assert (@(posedge clk) disable iff (!reset)
    (carry === (a[WIDTH-1] & b[WIDTH-1]) |
     (a[WIDTH-1] & sum[WIDTH-2]) |
     (b[WIDTH-1] & sum[WIDTH-2])));

assert (@(posedge clk) disable iff (!reset)
    ((a == 'hFFFF && b == 'hFFFF) |-> carry === 1'b1)
        and
    ((a == 'h0 && b == 'h0) |-> carry === 1'b0));

endmodule