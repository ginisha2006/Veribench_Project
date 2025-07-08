module tb_alu_4bit();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  reg Carry;
  reg Overflow;

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

  // Properties for each operation

  // ADD Operation
  property p_add_result;
    @(posedge clk) (ALU_Sel == 3'b000) |-> (ALU_Result === a + b);
  endproperty
  assert property (p_add_result);

  property p_add_carry;
    @(posedge clk) (ALU_Sel == 3'b000) |-> (Carry === (a + b)[4]);
  endproperty
  assert property (p_add_carry);

  property p_add_overflow;
    @(posedge clk) (ALU_Sel == 3'b000) |-> (Overflow === ((a[3] == b[3]) && (ALU_Result[3] != a[3])));
  endproperty
  assert property (p_add_overflow);

  // SUB Operation
  property p_sub_result;
    @(posedge clk) (ALU_Sel == 3'b001) |-> (ALU_Result === a - b);
  endproperty
  assert property (p_sub_result);

  property p_sub_carry;
    @(posedge clk) (ALU_Sel == 3'b001) |-> (Carry === (a < b));
  endproperty
  assert property (p_sub_carry);

  // AND Operation
  property p_and_result;
    @(posedge clk) (ALU_Sel == 3'b010) |-> (ALU_Result === a & b);
  endproperty
  assert property (p_and_result);

  // OR Operation
  property p_or_result;
    @(posedge clk) (ALU_Sel == 3'b011) |-> (ALU_Result === a | b);
  endproperty
  assert property (p_or_result);

  // XOR Operation
  property p_xor_result;
    @(posedge clk) (ALU_Sel == 3'b100) |-> (ALU_Result === a ^ b);
  endproperty
  assert property (p_xor_result);

  // NOT Operation
  property p_not_result;
    @(posedge clk) (ALU_Sel == 3'b101) |-> (ALU_Result === ~a);
  endproperty
  assert property (p_not_result);

  // SHL Operation
  property p_shl_result;
    @(posedge clk) (ALU_Sel == 3'b110) |-> (ALU_Result === a << 1);
  endproperty
  assert property (p_shl_result);

  // SHR Operation
  property p_shr_result;
    @(posedge clk) (ALU_Sel == 3'b111) |-> (ALU_Result === a >> 1);
  endproperty
  assert property (p_shr_result);

  // Zero Detection
  property p_zero_detection;
    @(posedge clk) (ALU_Result == 4'b0000) |-> (Zero === 1);
    @(posedge clk) (ALU_Result !== 4'b0000) |-> (Zero === 0);
  endproperty
  assert property (p_zero_detection);

endmodule