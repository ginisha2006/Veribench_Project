module fibonacci_gen(clk, rst, start, n, fib);

  parameter WIDTH = 8;

  input clk;
  input rst;
  input start;
  input [WIDTH-1:0] n;
  output [WIDTH-1:0] fib;

  reg [WIDTH-1:0] f0;
  reg [WIDTH-1:0] f1;
  reg [WIDTH-1:0] fn;

  always @(posedge clk) begin
    if (rst) begin
      f0 <= 0;
      f1 <= 1;
      fn <= 0;
    end else if (start) begin
      if (n == 0) begin
        fn <= f0;
      end else if (n == 1) begin
        fn <= f1;
      end else begin
        fn <= f0 + f1;
        f0 <= f1;
        f1 <= fn;
      end
    end
  end

  assign fib = fn;

endmodule