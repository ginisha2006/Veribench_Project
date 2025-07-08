module tb_alu_4bit ();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

  // Instantiate the ALU
  alu_4bit dut (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_add_correct;
    @(posedge clk) (ALU_Result == a + b);
  endproperty
  assert property (p_add_correct);

  property p_sub_correct;
    @(posedge clk) (ALU_Result == a - b);
  endproperty
  assert property (p_sub_correct);

  property p_and_correct;
    @(posedge clk) (ALU_Result == a & b);
  endproperty
  assert property (p_and_correct);

  property p_or_correct;
    @(posedge clk) (ALU_Result == a | b);
  endproperty
  assert property (p_or_correct);

  property p_xor_correct;
    @(posedge clk) (ALU_Result == a ^ b);
  endproperty
  assert property (p_xor_correct);

  property p_not_correct;
    @(posedge clk) (ALU_Result == ~a);
  endproperty
  assert property (p_not_correct);

  property p_shl_correct;
    @(posedge clk) (ALU_Result == a << 1);
  endproperty
  assert property (p_shl_correct);

  property p_shr_correct;
    @(posedge clk) (ALU_Result == a >> 1);
  endproperty
  assert property (p_shr_correct);

  property p_overflow_add;
    @(posedge clk) (!(ALU_Sel == 3'b000) || !((a[3] == b[3]) && (ALU_Result[3] != a[3])));
  endproperty
  assert property (p_overflow_add);

  property p_zero_check;
    @(posedge clk) (Zero == (ALU_Result == 4'b0000));
  endproperty
  assert property (p_zero_check);


endmodule