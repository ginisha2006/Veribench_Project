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

  // Property: Check ALU result for addition
  property p_addition;
    @(posedge clk) (ALU_Sel == 3'b000) => (ALU_Result == (a + b));
  endproperty
  assert property (p_addition);

  // Property: Check ALU result for subtraction
  property p_subtraction;
    @(posedge clk) (ALU_Sel == 3'b001) => (ALU_Result == (a - b));
  endproperty
  assert property (p_subtraction);

  // Property: Check ALU result for AND operation
  property p_and;
    @(posedge clk) (ALU_Sel == 3'b010) => (ALU_Result == (a & b));
  endproperty
  assert property (p_and);

  // Property: Check ALU result for OR operation
  property p_or;
    @(posedge clk) (ALU_Sel == 3'b011) => (ALU_Result == (a | b));
  endproperty
  assert property (p_or);

  // Property: Check ALU result for XOR operation
  property p_xor;
    @(posedge clk) (ALU_Sel == 3'b100) => (ALU_Result == (a ^ b));
  endproperty
  assert property (p_xor);

  // Property: Check ALU result for NOT operation
  property p_not;
    @(posedge clk) (ALU_Sel == 3'b101) => (ALU_Result == (~a));
  endproperty
  assert property (p_not);

  // Property: Check ALU result for left shift
  property p_left_shift;
    @(posedge clk) (ALU_Sel == 3'b110) => (ALU_Result == (a << 1));
  endproperty
  assert property (p_left_shift);

  // Property: Check ALU result for right shift
  property p_right_shift;
    @(posedge clk) (ALU_Sel == 3'b111) => (ALU_Result == (a >> 1));
  endproperty
  assert property (p_right_shift);

  // Property: Check overflow flag
  property p_overflow;
    @(posedge clk) (ALU_Sel == 3'b000) && ((a[3] == b[3]) && (ALU_Result[3]!= a[3])) => Overflow;
  endproperty
  assert property (p_overflow);

  // Property: Check zero flag
  property p_zero;
    @(posedge clk) (ALU_Result == 4'b0000) => Zero;
  endproperty
  assert property (p_zero);

endmodule