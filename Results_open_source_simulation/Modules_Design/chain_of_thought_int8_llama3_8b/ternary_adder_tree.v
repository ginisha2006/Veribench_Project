module ternary_adder_tree #(parameter WIDTH = 16)
    (input wire [WIDTH-1:0] A,
     input wire [WIDTH-1:0] B,
     input wire [WIDTH-1:0] C,
     input wire [WIDTH-1:0] D,
     input wire [WIDTH-1:0] E,
     input wire CLK,
     output reg [WIDTH-1:0] OUT);

wire [WIDTH-1:0] T1;
wire [WIDTH-1:0] T2;

assign T1 = A + B + C;
assign T2 = D + E;

always @(posedge CLK)
begin
    OUT <= T1 + T2;
end

endmodule