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

property p_no_overflow;
    @(posedge clk) disable iff (!($isunknown(a) || $isunknown(b) || $isunknown(cin)))
        ($rose(cout)) |-> (a == 1 && b == 1 && cin == 1);
endproperty

assert property(p_no_overflow);

property p_sum_behavior;
    @(posedge clk) disable iff (!($isunknown(a) || $isunknown(b) || $isunknown(cin)))
        (a === 0 && b === 0 && cin === 0) |=> (sum === 0 && cout === 0);
    (a === 0 && b === 0 && cin === 1) |=> (sum === 1 && cout === 0);
    (a === 0 && b === 1 && cin === 0) |=> (sum === 1 && cout === 0);
    (a === 0 && b === 1 && cin === 1) |=> (sum === 0 && cout === 1);
    (a === 1 && b === 0 && cin === 0) |=> (sum === 1 && cout === 0);
    (a === 1 && b === 0 && cin === 1) |=> (sum === 0 && cout === 1);
    (a === 1 && b === 1 && cin === 0) |=> (sum === 0 && cout === 1);
    (a === 1 && b === 1 && cin === 1) |=> (sum === 1 && cout === 1);
endproperty

assert property(p_sum_behavior);

endmodule