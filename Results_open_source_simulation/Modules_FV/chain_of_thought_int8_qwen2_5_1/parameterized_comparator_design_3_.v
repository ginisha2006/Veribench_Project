module tb_param_comparator (
    input [7:0] A,
    input [7:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less,
    input clk
);

wire [7:0] A;
wire [7:0] B;
reg Equal;
reg Greater;
reg Less;

param_comparator #(.WIDTH(8)) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
);

always begin
    clk = 1'b0; #(5); clk = 1'b1; #(5);
end

property p_equal;
    @(posedge clk) disable iff (!reset)
    (A == B) |-> Equal === 1'b1 else Equal === 1'b0;
endproperty
assert property(p_equal);

property p_greater;
    @(posedge clk) disable iff (!reset)
    (A > B) |-> Greater === 1'b1 else Greater === 1'b0;
endproperty
assert property(p_greater);

property p_less;
    @(posedge clk) disable iff (!reset)
    (A < B) |-> Less === 1'b1 else Less === 1'b0;
endproperty
assert property(p_less);

property p_exclusive_outputs;
    @(posedge clk) disable iff (!reset)
    !(Equal & Greater) && !(Equal & Less) && !(Greater & Less);
endproperty
assert property(p_exclusive_outputs);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    ($past(A == 8'hFF) && $rose(B)) |=> !Equal && !Greater && Less;
endproperty
assert property(p_edge_cases);

property p_underflow;
    @(posedge clk) disable iff (!reset)
    !$isunknown({A,B}) |-> !($signed(A) < $signed(B) && $signed(B) - $signed(A) >= 2**WIDTH);
endproperty
assert property(p_underflow);

property p_overflow;
    @(posedge clk) disable iff (!reset)
    !$isunknown({A,B}) |-> !($signed(A) > $signed(B) && $signed(A) - $signed(B) >= 2**WIDTH);
endproperty
assert property(p_overflow);

endmodule