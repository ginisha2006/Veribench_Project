module ternary_adder_tree #(parameter WIDTH = 16) (
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input [WIDTH-1:0] C,
    input [WIDTH-1:0] D,
    input [WIDTH-1:0] E,
    input CLK,
    output [WIDTH-1:0] OUT
); 

always @(posedge CLK) begin
    if (A == 2'b01 || B == 2'b01 || C == 2'b01 || D == 2'b01 || E == 2'b01)
        OUT <= A ^ B ^ C ^ D ^ E;
    else if (A == 2'b10 || B == 2'b10 || C == 2'b10 || D == 2'b10 || E == 2'b10)
        OUT <= A ^ B ^ C ^ D ^ E;
    else if (A == 2'b11 || B == 2'b11 || C == 2'b11 || D == 2'b11 || E == 2'b11)
        OUT <= A ^ B ^ C ^ D ^ E;
    else
        OUT <= 0;
end

endmodule