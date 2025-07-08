module param_adder #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] sum,
    output reg carry
);
    always @(*) begin
        {carry,sum} = a + b;
    end
endmodule