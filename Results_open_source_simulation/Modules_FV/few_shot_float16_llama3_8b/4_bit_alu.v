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

  // Property: Check if result is correct for each operation
  property p_correct_result_ADD;
    @(posedge clk) (ALU_Sel == 3'b000) => ({Carry, ALU_Result} == a + b);
  endproperty
  assert property (p_correct_result_ADD);

  property p_correct_result_SUB;
    @(posedge clk) (ALU_Sel == 3'b001) => ({Carry, ALU_Result} == a - b);
  endproperty
  assert property (p_correct_result_SUB);

  property p_correct_result_AND;
    @(posedge clk) (ALU_Sel == 3'b010) => ALU_Result == a & b;
  endproperty
  assert property (p_correct_result_AND);

  property p_correct_result_OR;
    @(posedge clk) (ALU_Sel == 3'b011) => ALU_Result == a | b;
  endproperty
  assert property (p_correct_result_OR);

  property p_correct_result_XOR;
    @(posedge clk) (ALU_Sel == 3'b100) => ALU_Result == a ^ b;
  endproperty
  assert property (p_correct_result_XOR);

  property p_correct_result_NOT;
    @(posedge clk) (ALU_Sel == 3'b101) => ALU_Result == ~a;
  endproperty
  assert property (p_correct_result_NOT);

  property p_correct_result_SHL;
    @(posedge clk) (ALU_Sel == 3'b110) => ALU_Result == a << 1;
  endproperty
  assert property (p_correct_result_SHL);

  property p_correct_result_SHR;
    @(posedge clk) (ALU_Sel == 3'b111) => ALU_Result == a >> 1;
  endproperty
  assert property (p_correct_result_SHR);

  // Property: Check if zero flag is set correctly
  property p_zero_flag;
    @(posedge clk) Zero == (ALU_Result == 4'b0000);
  endproperty
  assert property (p_zero_flag);

  // Property: Check if overflow flag is set correctly
  property p_overflow_flag;
    @(posedge clk) Overflow == (ALU_Sel == 3'b000) && ((a[3] == b[3]) && (ALU_Result[3]!= a[3]));
  endproperty
  assert property (p_overflow_flag);

endmodule