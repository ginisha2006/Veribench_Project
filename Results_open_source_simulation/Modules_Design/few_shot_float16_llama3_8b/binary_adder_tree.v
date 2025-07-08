module binary_adder_tree (
    input [15:0] A, B, C, D, E,
    input clk,
    output [15:0] out
);
    wire [15:0] s1, s2, s3, s4;

    always @(posedge clk)
        begin
            {s1, s2} = A + B;
        end

    always @(posedge clk)
        begin
            {s3, s4} = s1 + C;
        end

    always @(posedge clk)
        begin
            out = s3 + D;
        end

    always @(posedge clk)
        begin
            out = out + E;
        end
endmodule