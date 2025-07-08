module tb_fibonacci_gen #(parameter WIDTH = 8)();

  // Inputs
  reg clk;
  reg rst;
  reg start;
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

  // Property: Check if fib is correct when n is 3
  always @(*) begin assert (@(posedge clk) (n == 3) |=> (fib == 2)); end

  // Property: Check if fib is correct when n is 4
  always @(*) begin assert (@(posedge clk) (n == 4) |=> (fib == 3)); end

  // Property: Check if fib is correct when n is 5
  always @(*) begin assert (@(posedge clk) (n == 5) |=> (fib == 5)); end

  // Property: Check if fib is correct when n is greater than 5
  always @(*) begin assert (@(posedge clk) ((n > 5) && (n < 16)) |=> (fib == (fibonacci_seq(n)))); end

  // Function to calculate the nth Fibonacci number
  function integer fibonacci_seq(input integer n);
    integer i;
    integer result = 0;
    integer prev = 0;
    integer curr = 1;
    for (i = 0; i < n - 1; i++) begin
      result = prev + curr;
      prev = curr;
      curr = result;
    end
    return(result);
  endfunction

endmodule