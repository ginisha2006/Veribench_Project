module ternary_adder_tree #(parameter WIDTH=16) (
    input [WIDTH-1:0] A, B, C, D, E,
    input CLK,
    output [WIDTH-1:0] OUT
);
    wire [WIDTH-1:0] temp;
    reg [WIDTH-1:0] sum;
    
    always @(posedge CLK)
        begin
            sum <= A + B;
            temp <= {C, sum};
        end
    
    always @(posedge CLK)
        begin
            sum <= temp + D;
            OUT <= {E, sum};
        end
endmodule