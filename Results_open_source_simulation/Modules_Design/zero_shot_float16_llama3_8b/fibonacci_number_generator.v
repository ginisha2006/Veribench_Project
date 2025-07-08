module fibonacci_gen #(parameter WIDTH = 8)
    (input wire clk,
     input wire rst,
     input wire start,
     input wire [WIDTH-1:0] n,
     output reg [WIDTH-1:0] fib);

reg [WIDTH-1:0] a, b;
reg [WIDTH-1:0] temp;

always @(posedge clk) begin
    if (rst) begin
        a <= 0;
        b <= 1;
        fib <= 0;
    end else if (start) begin
        if (n > 1) begin
            temp <= a + b;
            a <= b;
            b <= temp;
            n <= n - 1;
        end else begin
            fib <= a;
        end
    end
end

endmodule