module tb_param_comparator (
    input [7:0] A,
    input [7:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less,
    input clk
);

param_comparator #(.WIDTH(8)) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
);

property p_equal;
    @(posedge clk) disable iff (!reset)
    (A == B) |-> Equal === 1'b1;
endproperty
assert property(p_equal);

property p_greater;
    @(posedge clk) disable iff (!reset)
    (A > B) |-> Greater === 1'b1;
endproperty
assert property(p_greater);

property p_less;
    @(posedge clk) disable iff (!reset)
    (A < B) |-> Less === 1'b1;
endproperty
assert property(p_less);

property p_exclusive_outputs;
    @(posedge clk) disable iff (!reset)
    !(Equal & Greater) && !(Equal & Less) && !(Greater & Less);
endproperty
assert property(p_exclusive_outputs);

endmodule