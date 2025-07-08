module param_comparator #(parameter WIDTH = 8);
input [WIDTH-1:0] A;
input [WIDTH-1:0] B;
output logic Equal;
output logic Greater;
output logic Less;

always @(*) begin
    if(A == B)
        Equal = 1'b1;
    else if(A > B)
        Greater = 1'b1;
    else
        Less = 1'b1;
end
endmodule