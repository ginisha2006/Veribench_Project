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

always @(posedge clk) begin
    if(rst)
        fib <= 0;
    else if(start) begin
        if(n == 0)
            fib <= 0;
        else if(n == 1)
            fib <= 1;
        else begin
            fib <= 1;
            prev_fib <= 0;
            for(int i=2; i<=n; i=i+1) begin
                temp = fib + prev_fib;
                prev_fib <= fib;
                fib <= temp;
            end
        end
    end
end

endmodule