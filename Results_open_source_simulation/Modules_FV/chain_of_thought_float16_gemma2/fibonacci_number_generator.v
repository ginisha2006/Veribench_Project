module tb_fibonacci_gen (
);
  reg clk;
  reg rst;
  reg start;
  reg [7:0] n;
  wire [7:0] fib;

  fibonacci_gen #(8) dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .n(n),
    .fib(fib)
  );

  property p_fibonacci_sequence;
    @(posedge clk) $past(fib) + $past($past(fib)) == fib;
  endproperty

  property p_reset;
    @(posedge clk) | rst == 1'b1  => fib == 8'd0;
  endproperty

  property p_start_condition;
    @(posedge clk) start == 1'b1 && n != 8'h00 => count < n;
  endproperty

  assert property (p_fibonacci_sequence);
  assert property (p_reset);
  assert property (p_start_condition);

  always #5 clk = ~clk;
  initial begin
    rst = 1'b1;
    #10 rst = 1'b0;
    start = 1'b0;
    n = 8'd5;
    start = 1'b1;
  end
endmodule