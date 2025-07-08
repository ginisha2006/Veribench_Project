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
            Equal <= 1'b1;
        else
            Equal <= 1'b0;

        if (A > B)
            Greater <= 1'b1;
        else
            Greater <= 1'b0;

        if (A < B)
            Less <= 1'b1;
        else
            Less <= 1'b0;
    end
endmodule