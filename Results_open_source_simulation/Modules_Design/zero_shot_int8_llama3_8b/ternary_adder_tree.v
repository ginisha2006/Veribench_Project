module ternary_adder_tree #(parameter WIDTH = 16)
    (
        input [WIDTH-1:0] A,
        input [WIDTH-1:0] B,
        input [WIDTH-1:0] C,
        input [WIDTH-1:0] D,
        input [WIDTH-1:0] E,
        input CLK,
        output [WIDTH-1:0] OUT
    );

wire [WIDTH-1:0] t1;
wire [WIDTH-1:0] t2;

always @(posedge CLK) begin
    t1 <= {A[WIDTH-1:0], B[WIDTH-1:0]};
    t2 <= {C[WIDTH-1:0], D[WIDTH-1:0]};
end

assign OUT = (E[WIDTH-1:0] + t1 + t2);

endmodule