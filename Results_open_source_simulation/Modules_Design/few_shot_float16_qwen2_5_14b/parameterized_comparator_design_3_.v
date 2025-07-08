module param_comparator #(
    parameter WIDTH=8
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output Equal,
    output Greater,
    output Less
);
    assign Equal = (A == B);
    assign Greater = (A > B);
    assign Less = (A < B);
endmodule