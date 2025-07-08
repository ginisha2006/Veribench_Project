module tb_param_comparator;

parameter WIDTH = 8;
reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
wire Equal;
wire Greater;
wire Less;

param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

property p_equal;
    @(posedge clk) ($rose(Equal) |-> ($onehot({A, B} == {A, B}));
endproperty

property p_greater;
    @(posedge clk) ($rose(Greater) |-> (A > B));
endproperty

property p_less;
    @(posedge clk) ($rose(Less) |-> (A < B));
endproperty

property p_overflow;
    @(posedge clk) ((A >= 2**WIDTH - 1) |-> ($isunknown(Greater)) & ($isunknown(Less)));
endproperty

property p_underflow;
    @(posedge clk) ((A <= -2**WIDTH + 1) |-> ($isunknown(Less)) & ($isunknown(Greater)));
endproperty

property p_illegal_transition;
    @(posedge clk) (!($isunknown(A)) &!($isunknown(B)) & (|{A, B})[WIDTH-1] && ({A, B}[WIDTH-1]) |-> ($isunknown(Equal) | $isunknown(Greater) | $isunknown(Less)));
endproperty

assert property (p_equal);
assert property (p_greater);
assert property (p_less);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_illegal_transition);

endmodule