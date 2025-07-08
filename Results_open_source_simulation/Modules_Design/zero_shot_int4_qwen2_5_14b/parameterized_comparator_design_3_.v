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
    if(A == B)
        {Greater,Less,Equal} <= 2'b0;
    else if(A > B)
        {Greater,Less,Equal} <= 3'b100;
    else if(A < B)
        {Greater,Less,Equal} <= 3'b010;
end
endmodule