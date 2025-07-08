module param_adder #(parameter WIDTH = 8)
    (input [WIDTH-1:0] a,
     input [WIDTH-1:0] b,
     output [WIDTH-1:0] sum,
     output carry);

reg [WIDTH:0] temp;

always @* begin
    temp = a + b;
    sum = temp[WIDTH-1:0];
    carry = temp[WIDTH];
end

endmodule