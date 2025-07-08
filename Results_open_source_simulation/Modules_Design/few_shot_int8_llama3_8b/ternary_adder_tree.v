module ternary_adder_tree #(parameter WIDTH=16) (
    input [WIDTH-1:0] A, B, C, D, E,
    input CLK,
    output [WIDTH-1:0] OUT
);
    wire [WIDTH-1:0] temp;
    reg [WIDTH-1:0] carry;

    always @(posedge CLK)
        begin
            {carry,temp} = {C,D,E};
        end

    always @(posedge CLK)
        begin
            {OUT,temp} = {temp,A,B};
        end

    assign OUT[0] = carry;
endmodule