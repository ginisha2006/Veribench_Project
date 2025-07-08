module tb_param_comparator;

parameter WIDTH = 8;
logic [WIDTH-1:0] A, B;
logic Equal, Greater, Less;
param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

property p_equal;
    @(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Equal);
endproperty

property p_greater;
    @(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Greater);
endproperty

property p_less;
    @(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Less);
endproperty

property p_overflow;
    @(posedge clk) ((A >= 2**WIDTH - 1) | (B >= 2**WIDTH - 1));
endproperty

property p_underflow;
    @(posedge clk) ((A <= -(2**WIDTH)) | (B <= -(2**WIDTH)));
endproperty

assert property (p_equal);
assert property (p_greater);
assert property (p_less);
assert property (p_overflow);
assert property (p_underflow);

endmodule