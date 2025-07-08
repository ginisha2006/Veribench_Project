module tb_param_comparator;

parameter WIDTH = 8;
logic [WIDTH-1:0] A, B;
logic Equal, Greater, Less;

param_comparator #(WIDTH) dut (
   .A(A),
   .B(B),
   .Equal(Equal),
   .Greater(Greater),
   .Less(Less)
);

property p_equal;
    @(posedge clk);
    ($rose(A) && $fell(B)) |-> (Equal);
endproperty

property p_greater;
    @(posedge clk);
    ($rose(A) && $fell(B)) |-> (Greater);
endproperty

property p_less;
    @(posedge clk);
    ($rose(A) && $fell(B)) |-> (Less);
endproperty

property p_edge_cases;
    @(posedge clk);
    ($rose(A) && $stable(B)) |-> (~Equal);
    ($fell(A) && $stable(B)) |-> (~Equal);
    ($rose(A) && $rose(B)) |-> (~Greater);
    ($fell(A) && $fell(B)) |-> (~Less);
endproperty

property p_overflow_underflow;
    @(posedge clk);
    ($rose(A)[$high(A)]) |-> (~Equal);
    ($fell(A)[$low(A)]) |-> (~Equal);
    ($rose(B)[$high(B)]) |-> (~Equal);
    ($fell(B)[$low(B)]) |-> (~Equal);
endproperty

assert property (p_equal);
assert property (p_greater);
assert property (p_less);
assert property (p_edge_cases);
assert property (p_overflow_underflow);

endmodule