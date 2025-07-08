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

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!($isunknown({a,b,cin})))
        ({a,b,cin,sum,cout}) inside {
            {0,0,0,0,0},
            {0,0,1,1,0},
            {0,1,0,1,0},
            {0,1,1,0,1},
            {1,0,0,1,0},
            {1,0,1,0,1},
            {1,1,0,0,1},
            {1,1,1,1,1}
        };
endproperty

assert property(p_no_overflow_underflow);

property p_sum_correct;
    @(posedge clk) disable iff (!($isunknown({a,b,cin})))
        sum == (a ^ b ^ cin);
endproperty

assert property(p_sum_correct);

property p_carry_out_correct;
    @(posedge clk) disable iff (!($isunknown({a,b,cin})))
        cout == (a & b) | (b & cin) | (a & cin);
endproperty

assert property(p_carry_out_correct);

endmodule