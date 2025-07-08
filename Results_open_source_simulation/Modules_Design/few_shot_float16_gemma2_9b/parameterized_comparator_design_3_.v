module param_comparator #(parameter WIDTH=8) (
    input [WIDTH-1:0] A, B,
    output reg Equal,
    output reg Greater,
    output reg Less
);
    assign Equal = (A == B);
    assign Greater = (A > B);
    assign Less = (A < B);
endmodule