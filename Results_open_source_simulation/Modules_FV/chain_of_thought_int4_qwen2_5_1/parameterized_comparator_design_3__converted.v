module tb_param_comparator #(parameter WIDTH = 8) (
    input clk,
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less
);

param_comparator #(.WIDTH(WIDTH)) dut (
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
    !(Equal & Greater & Less));

assert (@(posedge clk) disable iff (!reset)
    !((Equal & Greater) || (Equal & Less) || (Greater & Less)));

endmodule