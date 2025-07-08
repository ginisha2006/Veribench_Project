module param_subtractor #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] diff,
    output reg borrow
);
    always @(*) begin
        {borrow,diff} = a - b;
    end
endmodule