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

  // Property: Check if ALU result is correct for addition
  property p_correct_addition;
    @(posedge clk) (ALU_Sel == 3'b000) -> ({Carry, ALU_Result} == a + b);
  endproperty
  assert property (p_correct_addition);

  // Property: Check if ALU result is correct for subtraction
  property p_correct_subtraction;
    @(posedge clk) (ALU_Sel == 3'b001) -> ({Carry, ALU_Result} == a - b);
  endproperty
  assert property (p_correct_subtraction);

  // Property: Check if ALU result is correct for AND operation
  property p_correct_and;
    @(posedge clk) (ALU_Sel == 3'b010) -> (ALU_Result == a & b);
  endproperty
  assert property (p_correct_and);

  // Property: Check if ALU result is correct for OR operation
  property p_correct_or;
    @(posedge clk) (ALU_Sel == 3'b011) -> (ALU_Result == a | b);
  endproperty
  assert property (p_correct_or);

  // Property: Check if ALU result is correct for XOR operation
  property p_correct_xor;
    @(posedge clk) (ALU_Sel == 3'b100) -> (ALU_Result == a ^ b);
  endproperty
  assert property (p_correct_xor);

  // Property: Check if ALU result is correct for NOT operation
  property p_correct_not;
    @(posedge clk) (ALU_Sel == 3'b101) -> (ALU_Result == ~a);
  endproperty
  assert property (p_correct_not);

  // Property: Check if ALU result is correct for shift left operation
  property p_correct_shl;
    @(posedge clk) (ALU_Sel == 3'b110) -> (ALU_Result == a << 1);
  endproperty
  assert property (p_correct_shl);

  // Property: Check if ALU result is correct for shift right operation
  property p_correct_shr;
    @(posedge clk) (ALU_Sel == 3'b111) -> (ALU_Result == a >> 1);
  endproperty
  assert property (p_correct_shr);

  // Property: Check if Overflow flag is set correctly for addition
  property p_correct_overflow_add;
    @(posedge clk) (ALU_Sel == 3'b000) -> (Overflow == ((a[3] == b[3]) && (ALU_Result[3]!= a[3])));
  endproperty
  assert property (p_correct_overflow_add);

  // Property: Check if Zero flag is set correctly
  property p_correct_zero;
    @(posedge clk) (Zero == (ALU_Result == 4'b0000));
  endproperty
  assert property (p_correct_zero);

endmodule