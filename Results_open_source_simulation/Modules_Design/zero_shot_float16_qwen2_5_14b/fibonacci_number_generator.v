module fibonacci_gen #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);
reg [WIDTH-1:0] count;
reg [WIDTH-1:0] fib_prev, fib_next;

always @(posedge clk or posedge rst)
begin
    if(rst)
        begin
            fib <= 0;
            count <= 0;
            fib_prev <= 0;
            fib_next <= 1;
        end
    else if(start)
        begin
            if(count == 0)
                fib <= 0;
            else if(count == 1)
                fib <= 1;
            else
                begin
                    fib <= fib_next;
                    fib_prev <= fib_next;
                    fib_next <= fib_prev + fib_next;
                end
            if(count < n)
                count <= count + 1;
            else
                count <= 0;
        end
end

endmodule