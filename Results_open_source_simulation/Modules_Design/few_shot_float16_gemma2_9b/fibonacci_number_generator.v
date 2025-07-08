module fibonacci_gen #(parameter WIDTH=8) (
    input clk,
    input rst,
    input start,
    input [WIDTH-1:0] n,
    output reg [WIDTH-1:0] fib
);

  always @(posedge clk) begin
    if (rst) begin
      fib <= 0;
    end else if (start) begin
      // Fibonacci calculation logic here
    end
  end

endmodule