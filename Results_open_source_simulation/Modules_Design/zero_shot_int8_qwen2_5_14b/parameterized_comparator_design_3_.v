module param_comparator #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less
);
    always @(*) begin
        if (A == B)
            Equal <= 1;
        else
            Equal <= 0;

        if (A > B)
            Greater <= 1;
        else
            Greater <= 0;

        if (A < B)
            Less <= 1;
        else
            Less <= 0;
    end
endmodule