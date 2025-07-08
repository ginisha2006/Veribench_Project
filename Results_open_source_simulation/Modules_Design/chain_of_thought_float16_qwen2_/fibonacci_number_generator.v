module fibonacci_gen #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);

reg [WIDTH-1:0] prev_fib;
reg [WIDTH-1:0] temp;
integer i;

always @(posedge clk or posedge rst)
begin
    if(rst)
        fib <= 0;
    else if(start)
    begin
        prev_fib <= 0;
        fib <= 1;
        for(i=2; i<=n; i=i+1)
            begin
                temp = fib + prev_fib;
                prev_fib <= fib;
                fib <= temp;
            end
    end
end

endmodule