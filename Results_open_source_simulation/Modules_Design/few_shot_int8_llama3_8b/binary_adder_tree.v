module binary_adder_tree (
    input [15:0] A, B, C, D, E,
    input clk,
    output [15:0] out
);
    wire [15:0] s1, s2, s3, s4;

    always @(posedge clk)
        begin
            {s1} = A + B;
            {s2} = s1 + C;
            {s3} = s2 + D;
            {out} = s3 + E;
        end
endmodule