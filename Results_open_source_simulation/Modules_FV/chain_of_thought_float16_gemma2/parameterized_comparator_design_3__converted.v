module tb_param_comparator;

  parameter WIDTH = 8;
  reg [WIDTH-1:0] A;
  reg [WIDTH-1:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #(WIDTH) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  always @(*) begin assert (@(posedge clk) $past(Equal) |-> (A == B)); end
  always @(*) begin assert (@(posedge clk) $past(Greater) |-> (A > B)); end
  always @(*) begin assert (@(posedge clk) $past(Less) |-> (A < B)); end

endmodule