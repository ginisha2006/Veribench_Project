module fibonacci_gen #(parameter WIDTH=8) (
    input clk, rst, start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);
    reg [WIDTH-1:0] a, b;
    reg en;

    always @(posedge clk)
        if (rst) begin
            a <= 0; b <= 1; en <= 0;
        end else if (start &&!en) begin
            en <= 1;
        end else if (!start && en) begin
            en <= 0;
        end

    always @(posedge clk)
        if (en) begin
            fib <= b;
            if (n > 1) begin
                a <= b; b <= a + b;
            end
        end
endmodule