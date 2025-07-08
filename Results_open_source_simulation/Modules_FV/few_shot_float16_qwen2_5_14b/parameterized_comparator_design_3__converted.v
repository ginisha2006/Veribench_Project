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

  // Properties for formal verification

  // Property: Check if Equal is correctly asserted when A equals B
  always @(*) begin assert ((A == B) |-> (Equal === 1'b1)); end

  // Property: Check if Greater is correctly asserted when A is greater than B
  always @(*) begin assert ((A > B) |-> (Greater === 1'b1)); end

  // Property: Check if Less is correctly asserted when A is less than B
  always @(*) begin assert ((A < B) |-> (Less === 1'b1)); end

  // Property: Ensure that at most one of Equal, Greater, or Less can be true simultaneously
  assert property (@(posedge $rose(A) || posedge $rose(B)) p_exclusive_outputs);

endmodule