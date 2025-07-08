module fibonacci_gen #(parameter WIDTH = 8)(clk, rst, start, n, fib);

reg [WIDTH-1:0] fib_prev;
reg [WIDTH-1:0] fib_curr;

always @(posedge clk) begin
    if (rst) begin
        fib_prev <= 0;
        fib_curr <= 0;
    end else if (start) begin
        fib_prev <= 0;
        fib_curr <= 1;
    end else if (~start && n > 0) begin
        fib_prev <= fib_curr;
        fib_curr <= fib_prev + fib_prev;
    end
end

assign fib = fib_curr;

endmodule