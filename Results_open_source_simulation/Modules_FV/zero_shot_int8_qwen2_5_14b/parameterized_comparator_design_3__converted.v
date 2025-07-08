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

assert (@(posedge clk) disable iff (!reset)
    (A == B) |-> Equal === 1'b1);

assert (@(posedge clk) disable iff (!reset)
    (A > B) |-> Greater === 1'b1);

assert (@(posedge clk) disable iff (!reset)
    (A < B) |-> Less === 1'b1);

assert (@(posedge clk) disable iff (!reset)
    !(Equal & Greater) && !(Equal & Less) && !(Greater & Less));

endmodule