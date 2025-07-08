module tb_param_comparator #(parameter WIDTH = 8)();

  // Inputs
  reg [WIDTH-1:0] A, B;

  // Outputs
  wire Equal, Greater, Less;

  // Instantiate the comparator
  param_comparator #(.WIDTH(WIDTH)) UUT (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  // Properties for formal verification

  // Property: Equality check
  always @(*) begin assert (@(A,B) (Equal === (A == B))); end

  // Property: Greater than check
  always @(*) begin assert (@(A,B) (Greater === (A > B))); end

  // Property: Less than check
  always @(*) begin assert (@(A,B) (Less === (A < B))); end

endmodule