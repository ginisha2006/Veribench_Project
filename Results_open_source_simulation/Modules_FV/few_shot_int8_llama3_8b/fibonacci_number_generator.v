module tb_fibonacci_gen #(parameter WIDTH = 8)();

  // Inputs
  reg clk, rst, start;
  reg [WIDTH-1:0] n;

  // Output
  wire [WIDTH-1:0] fib;

  // Instantiate the DUT
  fibonacci_gen #(.WIDTH(WIDTH)) UUT (
   .clk(clk),
   .rst(rst),
   .start(start),
   .n(n),
   .fib(fib)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Check if fib is correct after reset
  property p_reset_fib;
    @(posedge clk) (fib == 0);
  endproperty
  assert property (p_reset_fib);

  // Property: Check if fib is correct when n is 0
  property p_n_zero;
    @(posedge clk) (start && n == 0) => (fib == 0);
  endproperty
  assert property (p_n_zero);

  // Property: Check if fib is correct when n is 1
  property p_n_one;
    @(posedge clk) (start && n == 1) => (fib == 1);
  endproperty
  assert property (p_n_one);

  // Property: Check if fib is correct for larger values of n
  property p_large_n;
    @(posedge clk) (start && n > 1) => (fib == (fibonacci_seq(n)));
  endproperty
  function integer fibonacci_seq(input integer n);
    integer i;
    fibonacci_seq = 0;
    for (i = 2; i <= n; i = i + 1) begin
      fibonacci_seq = fibonacci_seq + ((i - 1) % 2 == 0? 0 : 1);
    end
  endfunction
  assert property (p_large_n);

endmodule