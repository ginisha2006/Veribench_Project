module fibonacci_gen #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);

reg [WIDTH-1:0] prev_fib, next_fib;

always @(posedge clk or posedge rst)
begin
    if (rst)
        fib <= 0;
    else if (start)
    begin
        if (n == 0 || n == 1)
            fib <= n;
        else
        begin
            integer i;
            prev_fib <= 0;
            next_fib <= 1;
            for (i = 2; i <= n; i = i + 1)
            begin
                fib <= prev_fib + next_fib;
                prev_fib <= next_fib;
                next_fib <= fib;
            end
        end
    end
end

endmodule