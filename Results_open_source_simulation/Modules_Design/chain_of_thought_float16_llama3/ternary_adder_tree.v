module ternary_adder_tree #(parameter WIDTH = 16) (
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] C,
    input [WIDTH-1:0] D,
    input [WIDTH-1:0] E,
    input CLK,
    output [WIDTH-1:0] OUT
);

wire [WIDTH-1:0] temp;

always @(posedge CLK)
begin
    temp = A + B;
end

assign OUT = temp + C + D + E;

endmodule