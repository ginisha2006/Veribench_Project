module tb_full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

wire clk;

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

assert (@(posedge clk) disable iff (!reset)
    !($overflow({a,b,cin})) and !($underflow({a,b,cin})));

assert (@(posedge clk) disable iff (!reset)
    sum == (a ^ b ^ cin));

assert (@(posedge clk) disable iff (!reset)
    cout == ((a & b) | (b & cin) | (a & cin)));

assert (@(posedge clk) disable iff (!reset)
    // Edge case: all inputs high
    ($rose((a && b && cin)) |-> sum === 1'b0 && cout === 1'b1) &&
    // Edge case: all inputs low
    ($rose((!a && !b && !cin)) |-> sum === 1'b0 && cout === 1'b0) &&
    // Edge case: two inputs high one low
    (($rose(((a && b && !cin) || (a && !b && cin) || (!a && b && cin)))) |-> sum === 1'b1 && cout === 1'b1) &&
    // Edge case: one input high two low
    (($rose(((a && !b && !cin) || (!a && b && !cin) || (!a && !b && cin)))) |-> sum === 1'b1 && cout === 1'b0));

endmodule