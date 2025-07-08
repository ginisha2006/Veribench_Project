module tb_param_comparator;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] A;
  reg [WIDTH-1:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #(WIDTH) dut (A, B, Equal, Greater, Less);

  always @(*) begin assert (@(posedge clk) A == B implies Equal); end
  always @(*) begin assert (@(posedge clk) A > B implies Greater); end
  always @(*) begin assert (@(posedge clk) A < B implies Less); end
  always @(*) begin assert (@(posedge clk) (Equal | Greater | Less)); end

  always #5 clk = ~clk;
  reg clk;

endmodule