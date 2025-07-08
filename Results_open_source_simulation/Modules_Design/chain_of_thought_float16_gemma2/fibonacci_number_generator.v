module fibonacci_gen (
  input clk,
  input rst,
  input start,
  input [WIDTH-1:0] n,
  output reg [WIDTH-1:0] fib
);

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  reg [WIDTH-1:0] c;

  always @(posedge clk) begin
    if (rst) begin
      a <= 0;
      b <= 1;
      c <= 0;
    end else if (start) begin
      for (integer i = 0; i < n; i++) begin
        c <= a + b;
        a <= b;
        b <= c;
      end
      fib <= c;
    end
  end

endmodule