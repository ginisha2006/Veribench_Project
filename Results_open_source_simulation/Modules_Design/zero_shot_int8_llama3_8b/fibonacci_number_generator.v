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
        for (int i = 2; i < WIDTH; i++) begin
            temp <= a + b;
            a <= b;
            b <= temp;
        end
        fib <= b;
    end
end

endmodule