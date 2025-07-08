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
    else if (A > B)
        Greater <= 1;
    else 
        Less <= 1;
        
    Equal <= ~Equal & ~(Greater | Less);
    Greater <= ~Greater & ~(Equal | Less);
    Less <= ~Less & ~(Equal | Greater);
end

endmodule