module tb_param_comparator #(parameter WIDTH = 8) ();

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

  // Assertions

  // Property: Check if Equal is true when A equals B
  always @(*) begin assert ((A == B |-> Equal === 1'b1)); end

  // Property: Check if Equal is false when A does not equal B
  always @(*) begin assert (((A != B) |-> Equal === 1'b0)); end

  // Property: Check if Greater is true when A is greater than B
  always @(*) begin assert ((A > B |-> Greater === 1'b1)); end

  // Property: Check if Greater is false when A is less than or equal to B
  always @(*) begin assert ((!(A > B) |-> !(Greater))); end

  // Property: Check if Less is true when A is less than B
  always @(*) begin assert ((A < B |-> Less === 1'b1)); end

  // Property: Check if Less is false when A is greater than or equal to B
  always @(*) begin assert ((!(A < B) |-> !(Less))); end

endmodule