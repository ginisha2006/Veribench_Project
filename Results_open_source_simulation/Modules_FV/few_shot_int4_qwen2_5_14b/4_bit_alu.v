module tb_alu_4bit();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

  // Instantiate the DUT
  alu_4bit UUT (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Correct result for addition
  property p_correct_addition;
    @(posedge clk) (ALU_Sel == 3'b000) |-> ({Carry, ALU_Result} === a + b);
  endproperty
  assert property (p_correct_addition);

  // Property: Correct result for subtraction
  property p_correct_subtraction;
    @(posedge clk) (ALU_Sel == 3'b001) |-> ({Carry, ALU_Result} === a - b);
  endproperty
  assert property (p_correct_subtraction);

  // Property: Correct result for AND operation
  property p_correct_and;
    @(posedge clk) (ALU_Sel == 3'b010) |-> (ALU_Result === a & b);
  endproperty
  assert property (p_correct_and);

  // Property: Correct result for OR operation
  property p_correct_or;
    @(posedge clk) (ALU_Sel == 3'b011) |-> (ALU_Result === a | b);
  endproperty
  assert property (p_correct_or);

  // Property: Correct result for XOR operation
  property p_correct_xor;
    @(posedge clk) (ALU_Sel == 3'b100) |-> (ALU_Result === a ^ b);
  endproperty
  assert property (p_correct_xor);

  // Property: Correct result for NOT operation
  property p_correct_not;
    @(posedge clk) (ALU_Sel == 3'b101) |-> (ALU_Result === ~a);
  endproperty
  assert property (p_correct_not);

  // Property: Correct result for shift left operation
  property p_correct_shl;
    @(posedge clk) (ALU_Sel == 3'b110) |-> (ALU_Result === a << 1);
  endproperty
  assert property (p_correct_shl);

  // Property: Correct result for shift right operation
  property p_correct_shr;
    @(posedge clk) (ALU_Sel == 3'b111) |-> (ALU_Result === a >> 1);
  endproperty
  assert property (p_correct_shr);

  // Property: Correct zero detection
  property p_zero_detection;
    @(posedge clk) (ALU_Result == 4'b0000) |-> Zero;
  endproperty
  assert property (p_zero_detection);

  // Property: Correct carry detection during addition
  property p_correct_carry_addition;
    @(posedge clk) (ALU_Sel == 3'b000) && (a + b >= 16'd16) |-> Carry;
  endproperty
  assert property (p_correct_carry_addition);

  // Property: Correct overflow detection during addition
  property p_overflow_detection_addition;
    @(posedge clk) (ALU_Sel == 3'b000) && (a[3] == b[3]) && (ALU_Result[3] != a[3]) |-> Overflow;
  endproperty
  assert property (p_overflow_detection_addition);

endmodule