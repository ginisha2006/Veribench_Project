module tb_full_adder;

logic a, b, cin, sum, cout;
logic clk;

full_adder dut (
   .a(a),
   .b(b),
   .cin(cin),
   .sum(sum),
   .cout(cout)
);

property p_sum_correct;
@(posedge clk)
assert property ($onehot({1'b0, 1'b1}) => (sum == (a ^ b ^ cin)));
endproperty

property p_cout_correct;
@(posedge clk)
assert property ((a & b) | (b & cin) | (a & cin) => cout);
endproperty

property p_overflow_underflow;
@(posedge clk)
assert property (!($onehot({1'b0, 1'b1})) => (cout == (a && b) || (a && cin) || (b && cin));
endproperty

property p_edge_cases;
@(posedge clk)
assert property (a == 1'b0 && b == 1'b0 && cin == 1'b0 => sum == 1'b0 && cout == 1'b0);
@(posedge clk)
assert property (a == 1'b0 && b == 1'b0 && cin == 1'b1 => sum == 1'b1 && cout == 1'b1);
@(posedge clk)
assert property (a == 1'b0 && b == 1'b1 && cin == 1'b0 => sum == 1'b1 && cout == 1'b0);
@(posedge clk)
assert property (a == 1'b0 && b == 1'b1 && cin == 1'b1 => sum == 1'b0 && cout == 1'b1);
@(posedge clk)
assert property (a == 1'b1 && b == 1'b0 && cin == 1'b0 => sum == 1'b1 && cout == 1'b0);
@(posedge clk)
assert property (a == 1'b1 && b == 1'b0 && cin == 1'b1 => sum == 1'b0 && cout == 1'b1);
@(posedge clk)
assert property (a == 1'b1 && b == 1'b1 && cin == 1'b0 => sum == 1'b0 && cout == 1'b1);
@(posedge clk)
assert property (a == 1'b1 && b == 1'b1 && cin == 1'b1 => sum == 1'b1 && cout == 1'b1);

initial begin
    #10; // delay for clock stabilization
    repeat(100) @(posedge clk); // run for 100 cycles
end

always #5 clk = ~clk; // clock generation

endmodule