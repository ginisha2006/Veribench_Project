module tb_full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

wire clk;
reg a, b, cin;
wire sum, cout;

full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

always begin
    #5 clk = ~clk;
end

property p_no_overflows_underflows;
 @(posedge clk) disable iff (!reset)
 ($past(!($rose(a) || $rose(b) || $rose(cin)))) |-> 
 ((a == 0 && b == 0 && cin == 0) |->
  (sum == 0 && cout == 0)) ||
 ((a == 1 && b == 0 && cin == 0) |->
  (sum == 1 && cout == 0)) ||
 ((a == 0 && b == 1 && cin == 0) |->
  (sum == 1 && cout == 0)) ||
 ((a == 0 && b == 0 && cin == 1) |->
  (sum == 1 && cout == 0)) ||
 ((a == 1 && b == 1 && cin == 0) |->
  (sum == 0 && cout == 1)) ||
 ((a == 1 && b == 0 && cin == 1) |->
  (sum == 0 && cout == 1)) ||
 ((a == 0 && b == 1 && cin == 1) |->
  (sum == 0 && cout == 1)) ||
 ((a == 1 && b == 1 && cin == 1) |->
  (sum == 1 && cout == 1));
endproperty

assert property(p_no_overflows_underflows);

property p_functional_correctness;
 @(posedge clk) disable iff (!reset)
 (sum === (a ^ b ^ cin)) &&
 (cout === ((a & b) | (b & cin) | (a & cin)));
endproperty

assert property(p_functional_correctness);

property p_edge_cases;
 @(posedge clk) disable iff (!reset)
 (a === 0 && b === 0 && cin === 0) |->
 (sum === 0 && cout === 0);
 (a === 1 && b === 0 && cin === 0) |->
 (sum === 1 && cout === 0);
 (a === 0 && b === 1 && cin === 0) |->
 (sum === 1 && cout === 0);
 (a === 0 && b === 0 && cin === 1) |->
 (sum === 1 && cout === 0);
 (a === 1 && b === 1 && cin === 0) |->
 (sum === 0 && cout === 1);
 (a === 1 && b === 0 && cin === 1) |->
 (sum === 0 && cout === 1);
 (a === 0 && b === 1 && cin === 1) |->
 (sum === 0 && cout === 1);
 (a === 1 && b === 1 && cin === 1) |->
 (sum === 1 && cout === 1);
endproperty

assert property(p_edge_cases);

endmodule