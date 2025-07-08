module fibonacci_gen #(parameter WIDTH = 8)(clk, rst, start, n, fib);

input wire clk;
input wire rst;
input wire start;
input [WIDTH-1:0] n;

output reg [WIDTH-1:0] fib;

reg [WIDTH-1:0] fib_prev, fib_curr;

always @(posedge clk) begin
    if (rst) begin
        fib_prev <= 'b0;
        fib_curr <= 'b0;
    end else if (start) begin
        fib_prev <= 'b0;
        fib_curr <= 'b0;
        fib_prev <= n;
    end else if (~start && fib_prev!= 'b0) begin
        fib_curr <= fib_prev;
        fib_prev <= fib_prev + fib_prev[WIDTH-1];
    end
end

assign fib = fib_curr;

endmodule