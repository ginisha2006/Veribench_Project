module tb_alu_4bit;

  reg [3:0] a;
  reg [3:0] b;
  reg [2:0] ALU_Sel;
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

  alu_4bit dut (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  property add_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b000 && ALU_Result == a + b;
  endproperty

  property sub_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b001 && ALU_Result == a - b;
  endproperty

  property and_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b010 && ALU_Result == a & b;
  endproperty

  property or_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b011 && ALU_Result == a | b;
  endproperty

  property xor_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b100 && ALU_Result == a ^ b;
  endproperty

  property not_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b101 && ALU_Result == ~a;
  endproperty

  property shl_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b110 && ALU_Result == a << 1;
  endproperty

  property shr_correctness;
    @(posedge clk)
      $past(ALU_Sel) == 3'b111 && ALU_Result == a >> 1;
  endproperty

  property overflow_add;
    @(posedge clk)
      ALU_Sel == 3'b000 && !Overflow;
  endproperty

  property zero_check;
    @(posedge clk)
      Zero == (ALU_Result == 4'b0000);
  endproperty

  assert property(add_correctness);
  assert property(sub_correctness);
  assert property(and_correctness);
  assert property(or_correctness);
  assert property(xor_correctness);
  assert property(not_correctness);
  assert property(shl_correctness);
  assert property(shr_correctness);
  assert property(overflow_add);
  assert property(zero_check);

  always #5 ALU_Sel = ALU_Sel + 1;

endmodule