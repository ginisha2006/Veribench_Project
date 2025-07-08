module fibonacci_gen(
  input clk,
  input rst,
  input start,
  input [7:0] n,
  output reg [7:0] fib
);

  always @(posedge clk) begin
    if (rst) begin
      fib <= 0;
    end else if (start) begin
      reg [7:0] a = 0;
      reg [7:0] b = 1;
      for (int i = 2; i <= n; i++) begin
        reg [7:0] c = a + b;
        a <= b;
        b <= c;
      end
      fib <= b;
    end
  end

endmodule