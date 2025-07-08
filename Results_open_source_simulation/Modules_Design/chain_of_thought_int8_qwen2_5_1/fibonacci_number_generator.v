module fibonacci_gen #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);
    reg [WIDTH-1:0] prev_fib;
    reg [WIDTH-1:0] temp;
    reg [WIDTH-1:0] count;

    always @(posedge clk or posedge rst)
        if(rst)
            begin
                fib <= 0;
                prev_fib <= 0;
                temp <= 0;
                count <= 0;
            end
        else if(start)
            begin
                if(count == 0)
                    fib <= 0;
                else if(count == 1)
                    fib <= 1;
                else
                    begin
                        temp <= fib + prev_fib;
                        prev_fib <= fib;
                        fib <= temp;
                        count <= count + 1;
                    end
                if(n > count)
                    count <= count + 1;
                else
                    start <= 0;
            end

endmodule