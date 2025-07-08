module param_adder #(parameter WIDTH = 8)
    (
        input [WIDTH-1:0] a,
        input [WIDTH-1:0] b,
        output [WIDTH-1:0] sum,
        output carry
    );
    wire [WIDTH:0] temp;
    assign {carry, sum} = temp[WIDTh+1:0];
    always @* begin
        temp = a + b;
    end
endmodule