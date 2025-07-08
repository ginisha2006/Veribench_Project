module param_comparator #(
    parameter WIDTH=8
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output Equal,
    output Greater,
    output Less
);
    assign {Greater,Equal,Less} = A > B ? 2'b10 : (A < B ? 2'b01 : 3'b010);
endmodule