module fibonacci_gen #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);

reg [WIDTH-1:0] current, next;

always @(posedge clk or posedge rst)
begin
    if (rst)
        fib <= 0;
    else if (start)
    begin
        if (n == 0)
            fib <= 0;
        else if (n == 1)
            fib <= 1;
        else
        begin
            integer i;
            reg [WIDTH-1:0] f0, f1;
            f0 <= 0;
            f1 <= 1;
            for (i = 2; i <= n; i = i + 1)
            begin
                current <= f0 + f1;
                f0 <= f1;
                f1 <= current;
            end
            fib <= f1;
        end
    end
end

endmodule