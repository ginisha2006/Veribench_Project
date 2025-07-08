module fibonacci_gen #(parameter WIDTH=8)(
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);
reg [WIDTH-1:0] a, b;
always @(posedge clk or posedge rst)
begin
    if(rst)
        {a,b,fib} <= {2'd0,1'd0,1'd0};
    else if(start)
        case(n)
            0: fib <= 0;
            1: fib <= 1;
            default: begin
                a <= b;
                b <= a + b;
                fib <= b;
            end
        endcase
end
endmodule